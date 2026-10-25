SHOW ssl;
SHOW ssl_min_protocol_version;

SELECT
    s.pid,
    a.usename,
    a.client_addr,
    s.ssl,
    s.version,
    s.cipher
FROM pg_stat_ssl s
JOIN pg_stat_activity a ON a.pid = s.pid
WHERE s.pid = pg_backend_pid();

SHOW listen_addresses;

SELECT
    type,
    database,
    user_name,
    address,
    auth_method
FROM pg_hba_file_rules;
