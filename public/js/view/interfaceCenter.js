Ext.define('ghettoVCB.view.interfaceCenter', {
  extend: 'Ext.tab.Panel',
  alias: 'widget.interfaceCenter',
  layout: 'fit',
  autoShow: true,
  region: 'center',
  initComponent: function() {    
    Ext.ghettoVCB.views.interfaceCenter = this;

    this.callParent(arguments);
  }
});
