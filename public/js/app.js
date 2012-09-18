Ext.Loader.setConfig({
    enabled: true
});

Ext.namespace('Ext.ghettoVCB.util');

Ext.ghettoVCB.util.app = Ext.create('Ext.app.Application', {
    name: 'ghettoVCB',
    appFolder: 'js',

    controllers: [ 'interface' ],
    
    launch: function() {
        Ext.namespace('Ext.ghettoVCB.views');

        Ext.create('Ext.container.Viewport', {
            layout: 'border',
            renderTo: Ext.getBody(),
            items: [
                { xtype: 'interfaceWest'    },
                { xtype: 'interfaceEast'    },
                { xtype: 'interfaceCenter'  }
            ]
        });
    }
});
