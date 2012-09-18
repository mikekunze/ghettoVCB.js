Ext.define('ghettoVCB.view.ghettoWorkflowPanel', {
    extend: 'Ext.form.Panel',
    alias: 'widget.ghettoWorkflowPanel',
    title: 'Ghetto Workflow Panel',

    initComponent: function() {
        this.layout = 'anchor';
        this.flex = 1;

        this.defaultType = 'textfield';

        this.defaults = {
            anchor: '95%'
        };

        this.autoScroll = true;
        this.bodyPadding = 5;

        this.initialConfig.url = '/ghettoVCB/submitJobs';

        this.items = [
            {
                fieldLabel: 'ESXi Host',
                value: Ext.ghettoVCB.settings.defaultHost,
                readOnly: true,
                name: 'defaultHost'
            },
            {
                fieldLabel: 'VM Backup Volume',
                value: Ext.ghettoVCB.settings.dataPath,
                readOnly: true,
                name: 'vm_backup_volume'
            },
            {
                fieldLabel: 'Disk Backup Format',
                value: 'thin',
                readOnly: true,
                name: 'disk_backup_format'
            },
            {
                fieldLabel: 'Rotation Count',
                value: '2',
                readOnly: true,
                name: 'vm_backup_rotation_count'
            },
            {
                fieldLabel: 'Power VM Down',
                value: '0',
                name: 'power_vm_down_before_backup'
            },
            {
                fieldLabel: 'Enable Hard Power Off',
                value: '0',
                name: 'enable_hard_power_off'
            },
            {
                fieldLabel: 'Enable Compression',
                value: '0',
                name: 'enable_compression'
            },
            {
                fieldLabel: 'Snapshot Timeout',
                value: '15',
                name: 'snapshot_timeout'
            },
            {
                fieldLabel: 'Enable Email',
                value: '0',
                name: 'email_log'
            },
            {
                fieldLabel: 'Email Debug',
                value: '0',
                name: 'email_debug'
            },
            {
                fieldLabel: 'Email Server',
                value: 'callisto',
                name: 'email_server'
            },
            {
                fieldLabel: 'Email Server Port',
                value: '25',
                name: 'email_server_port'
            },
            {
                fieldLabel: 'Email Delay Interval',
                value: '1',
                name: 'email_delay_interval'
            },
            {
                fieldLabel: 'Email To',
                value: 'michael.kunze@gmail.com',
                name: 'email_to'
            },
            {
                fieldLabel: 'Email From',
                value: 'admin@revresxunil.net',
                name: 'email_from'
            },
            {
                fieldLabel: 'VMs To Backup',
                value: Ext.ghettoVCB.settings.vms_to_backup.split(',').join('\n'),
                name: 'vms_to_backup',
                xtype: 'textareafield',
                anchor: '%95 %25'
            }
        ];

        this.buttons = [{
            id: 'ghettoVCB.view.ghettoWorkflowPanel.submit',
            text: 'Submit ghettoVCB',
            formBind: true,
            scope: this
        }];

        this.callParent(arguments);
    }
});
