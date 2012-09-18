Ext.define('ghettoVCB.store.jobs', {
  extend: 'Ext.data.Store',
  model: 'ghettoVCB.model.job',
  storeId: 'jobs',
  pageSize: 100,
  proxy: {
    extraParams: {},
    api: {
      read: '/ghettoVCB/readJobs'
    },
    type: 'ajax',
    reader: {
      type: 'json',
      root: 'items',
      totalProperty: 'results'
    }
  }
});