Ext.define('ghettoVCB.view.interfaceEast', {
  extend: 'Ext.panel.Panel',
  title: 'Actions',
  alias: 'widget.interfaceEast',

  autoShow: true,
  requires: ['Ext.form.Panel'],

  initComponent: function() {
    this.collapsible  = true;
    this.collapsed    = true;
    this.region       = 'east';
    this.width        = 150;
    this.layout       = 'fit';
    
    Ext.ghettoVCB.views.interfaceEast = this;

    this.callParent(arguments);
  }
});
