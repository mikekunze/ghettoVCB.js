Ext.define('ghettoVCB.controller.historyViewer', {
  extend: 'Ext.app.Controller',
  stores: ['jobs'],
  models: ['job'],
  views:  ['historyGrid'],

  init: function() {
    console.log('[Client] - Initialized historyViewer controller');

    var historyGrid = Ext.create('ghettoVCB.view.historyGrid', {
      plugins: [{
        ptype: 'rowexpander',
        rowBodyTpl: [
            '<p><b>Workflow:</b> {scriptName}</p>',
            '<p><b>Start Time:</b> {startTime}</p>',
            '<p><b>End Time:</b> {endTime}</p>',
            '<p><b>Output:</b></p>{stdout:nl2br}'
        ]
      }]
    });
    Ext.ghettoVCB.views.interfaceCenter.add(historyGrid);

    this.control({
      'historyGrid': {
        render: function() {
          console.log('historyGrid view has rendered');
        }
      }
    });
  }
});