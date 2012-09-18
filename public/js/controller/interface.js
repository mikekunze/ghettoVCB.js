Ext.define('ghettoVCB.controller.interface', {
  extend: 'Ext.app.Controller',
  views:  ['interfaceEast', 'interfaceCenter', 'interfaceWest'],
  init: function() {
    console.log('[Client] - Initialized interface controller');
                
    this.control({
      'interfaceEast': {
        render: function() {
          console.log('rendered interfaceEast');
        }
      },
      'interfaceWest': {
        render: function() {
          console.log('rendered interfaceWest');
        }
      },
      'interfaceCenter': {
        render: function() {
          var app = Ext.ghettoVCB.util.app;

          // Get our apps
          var ghettoRunner = app.getController('ghettoVCB.controller.ghettoRunner');
          var historyGrid  = app.getController('ghettoVCB.controller.historyViewer');

          ghettoRunner.init();
          historyGrid.init();
        }
      }
    });
  }
});
