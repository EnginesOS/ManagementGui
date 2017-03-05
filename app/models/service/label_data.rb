class Service
  module LabelData

    def label_data
      {
        backup: {label: 'Backup', icon: 'fa-history'},
        cert_auth: {label: 'Certificates', icon: 'fa-certificate'},
        auth: {label: 'Authentication', icon: 'fa-user'},
        dhcpd: {label: 'DHCP server', icon: 'fa-tags'},
        dns: {label: 'DNS server', icon: 'fa-book'},
        dyndns: {label: 'Dynamic IP', icon: 'fa-bullhorn'},
        ftp: {label: 'FTP server', icon: 'fa-upload'},
        mgmt: {label: 'System GUI', icon: 'fa-dashboard'},
        mongo_server: {label: 'Mongo DB', icon: 'fa-database'},
        mysql_server: {label: 'MySQL DB', icon: 'fa-database'},
        nginx: {label: 'Router', icon: 'fa-random'},
        # cAdvisor: {label: 'Analytics', icon: 'fa-area-chart'},
        # wwwstats: {label: 'Monitor', icon: 'fa-bar-chart'},
        pgsql_server: {label: 'PostgreSQL DB', icon: 'fa-database'},
        smtp: {label: 'Mail out', icon: 'fa-send-o'},
        volmanager: {label: 'File system', icon: 'fa-folder-o'},
        # shareservice: {label: 'Sharing', icon: 'fa-share-alt'},
        # couriermail: {label: 'Mail in', icon: 'fa-inbox'},
        cron: {label: 'Jobs', icon: 'fa-calendar'},
        # servicemanager: {label: 'Services', icon: 'fa-arrows'},
        # awsdb: {label: 'AWS database', icon: 'fa-database'},
        email: {label: 'Mail server', icon: 'fa-envelope-o'},
        imap: {label: 'IMAP server', icon: 'fa-envelope-square'},
        syslog: {label: 'Logs', icon: 'fa-file-text-o'},
        nfs: {label: 'Network storage', icon: 'fa-folder-open-o'},
        avahi: {label: 'Discovery', icon: 'fa-map-signs'},
        log_rotate: {label: 'Log rotation', icon: 'fa-recycle'},
        logview: {label: 'Log viewer', icon: 'fa-file-text-o'}
      }
    end

  end
end
