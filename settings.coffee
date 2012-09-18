settings =
  defaultHost:          'esxi-host'
  scriptPath:           '/vmfs/volumes/2TB_Spindle/scripts/ghettoVCB'
  dataPath:             '/vmfs/volumes/2TB_Spindle/backups'
  dbHost:               'mongodb://localhost/ghettoVCB'
  smtpHost:             'localhost'
  vms_to_backup: [
    'vm1'
    'vm2'
    'vm3'
  ]

module.exports = settings
