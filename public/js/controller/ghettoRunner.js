Ext.define('ghettoVCB.controller.ghettoRunner', {
    extend: 'Ext.app.Controller',
    views:  ['ghettoRunnerTab', 'ghettoWorkflowPanel'],
    init: function() {
        console.log('[Client] - Initialized ghettoRunner controller');

        var ghettoRunnerTabPanel = Ext.create('ghettoVCB.view.ghettoRunnerTab');
        Ext.ghettoVCB.views.interfaceCenter.add(ghettoRunnerTabPanel);

        var ghettoWorkflowPanel = Ext.create('ghettoVCB.view.ghettoWorkflowPanel');

        ghettoRunnerTabPanel.add([ ghettoWorkflowPanel ]);

        this.control({
            'ghettoRunnerTab': {
                render: function() {
                    console.log('ghettoRunnerTab view has rendered');
                }
            },
            'ghettoWorkflowPanel': {
                render: function() {
                    console.log('ghettoWorkflowPanel view has rendered');
                }
            },
            'filePanel button[id=ghettoVCB.view.filePanel.refresh]': {
                click: function(button, event) {
                    Ext.data.StoreManager.lookup('ghettoVCB.store.fileStore').load();
                }
            },
            'ghettoWorkflowPanel button[id=ghettoVCB.view.ghettoWorkflowPanel.submit]': {
                click: function(button, event) {
                    var form = ghettoWorkflowPanel.getForm();

                    // Set status
                    Ext.getCmp('ghettoVCB.view.ghettoWorkflowPanel.statusLabel').setText('Status: submitting ghettoVCB job')
                    button.disable();

                    if (form.isValid()) {

                        form.submit({
                            params: {
                                workflow: 'ghettoVCB'
                            },
                            success: function(form, action) {
                                Ext.Msg.alert('Jobs Submitted', 'Your jobs have successfully been submitted');
                                Ext.getCmp('ghettoVCB.view.ghettoWorkflowPanel.statusLabel').setText('Status: submitted jobs');
                                button.enable();
                            },
                            failure: function(form, action) {
                                Ext.Msg.alert('Error', action.result.msg);
                            }
                        });
                    }
                }
            }
        });
    }
});
