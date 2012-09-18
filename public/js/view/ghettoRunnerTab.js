Ext.define('ghettoVCB.view.ghettoRunnerTab', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.ghettoRunnerTab',
    title: 'ghettoRunner',

    initComponent: function() {
        this.layout = {
            type: 'hbox',
            align: 'stretch'
        };

        this.bbar = [{
            id: 'ghettoVCB.view.ghettoWorkflowPanel.statusLabel',
            text: 'Status: ghettoRunner  is loaded',
            xtype: 'label',
            margin: '0 0 0 10'
        }];

        this.callParent(arguments);
    }
});
