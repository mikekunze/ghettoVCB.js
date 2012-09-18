Ext.Loader.setPath('Ext.ux','/extjs/examples/ux')
Ext.require(['Ext.ux.RowExpander']);

Ext.define('ghettoVCB.view.historyGrid', {
  extend: 'Ext.grid.Panel',
  alias: 'widget.historyGrid',
  title: 'historyGrid',
  initComponent: function() {
    this.columns = [
        {
          text: 'pid',
          dataIndex: 'pid',
          width: 80
        },
        {
          text: 'scriptName',
          dataIndex: 'scriptName',
          width: 200
        },
        {
          text: 'startTime',
          dataIndex: 'startTime',
          xtype: 'datecolumn',
          format: 'Y-m-d - H:i:s',
          width: 200
        },
        {
          text: 'endTime',
          dataIndex: 'endTime',
          xtype: 'datecolumn',
          format: 'Y-m-d - H:i:s',
          width: 200
        },
        {
          text: 'stdout',
          dataIndex: 'stdout',
          flex: 1
        }
    ];

    this.layout = 'fit';
    this.closable = false;

    this.store = Ext.create('ghettoVCB.store.jobs');

    this.dockedItems = [
      {
        xtype: 'pagingtoolbar',
        store: this.store,
        dock: 'top',
        displayInfo: true
      }
    ];

    this.store.load();

    this.callParent(arguments);
  }
});