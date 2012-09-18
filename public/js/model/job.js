Ext.define('ghettoVCB.model.job', {
  extend: 'Ext.data.Model',
  fields: [
      {
        name: 'pid',
        type: 'int'
      },
      {
        name: 'running',
        type: 'boolean'
      },
      {
        name: 'scriptName',
        type: 'string'
      },
      {
        name: 'stdout',
        type: 'string'
      },
      {
        name: 'startTime',
        type: 'date'
      },
      {
        name: 'endTime',
        type: 'date'
      }
  ],
  idProperty: '_id'
});