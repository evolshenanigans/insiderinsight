BEGIN;

CREATE TABLE IF NOT EXISTS schema_migrations (
    version VARCHAR NOT NULL PRIMARY KEY
);

INSERT INTO schema_migrations (version) VALUES
('20240320185228'),
('20240320200138'),
('20240320200147'),
('20240320200258'),
('20240320200453'),
('20240320200739'),
('20240322193304'),
('20240322194215'),
('20240325183402'),
('20240404154234'),
('20240404154244'),
('20240404154335'),
('20240404154427')
ON CONFLICT DO NOTHING;

CREATE TABLE IF NOT EXISTS ar_internal_metadata (
    key VARCHAR NOT NULL PRIMARY KEY,
    value VARCHAR,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

INSERT INTO ar_internal_metadata (key, value, created_at, updated_at) VALUES
('environment', 'development', '2024-03-25 17:38:07.236310', '2024-03-25 17:38:07.236310');

CREATE TABLE IF NOT EXISTS officials (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    party_affiliation VARCHAR,
    state VARCHAR,
    image_url VARCHAR
);

-- Sample insert for officials, repeat for others as needed
INSERT INTO officials (id, name, created_at, updated_at, party_affiliation, state, image_url) VALUES
(1, 'Gerry Connolly', '2024-03-25 18:11:00', '2024-03-25 18:11:00', 'Democrat', 'VA', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Gerry_Connolly_official_portrait_2022_%28cropped%29.jpg/440px-Gerry_Connolly_official_portrait_2022_%28cropped%29.jpg'),
(2, 'Michael Burgess', '2024-03-25 18:38:00', '2024-03-25 18:38:00', 'Republican', 'TX', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Michael_Burgess_117th_Congress.jpg/440px-Michael_Burgess_117th_Congress.jpg');
-- Include other INSERT statements as necessary

CREATE TABLE IF NOT EXISTS stocks (
    id SERIAL PRIMARY KEY,
    name VARCHAR DEFAULT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);


-- Adjusting 'users' table creation
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR NOT NULL UNIQUE,
    encrypted_password VARCHAR NOT NULL,
    reset_password_token VARCHAR UNIQUE,
    reset_password_sent_at TIMESTAMP,
    remember_created_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- Sample insert for 'users', adjust according to your data
INSERT INTO users (id, email, encrypted_password, created_at, updated_at) VALUES
(1, 'amanda@example.com', 'encrypted_password_example', '2024-03-25 18:12:52.512406', '2024-03-25 18:12:52.512406'),
(2, 'alice@example.com', 'encrypted_password_example', '2024-03-26 17:52:07.278140', '2024-03-26 17:52:07.278140');

-- Adjusting 'trades' table creation
CREATE TABLE IF NOT EXISTS trades (
    id SERIAL PRIMARY KEY,
    official_id INTEGER NOT NULL,
    stock_id INTEGER NOT NULL,
    transaction_type INTEGER DEFAULT 0,
    transaction_count INTEGER DEFAULT NULL,
    security_type VARCHAR DEFAULT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    FOREIGN KEY (official_id) REFERENCES officials (id),
    FOREIGN KEY (stock_id) REFERENCES stocks (id)
);

-- Sample insert for 'trades', adjust according to your data
INSERT INTO trades (id, official_id, stock_id, transaction_type, transaction_count, security_type, created_at, updated_at) VALUES
(1, 1, 1, 1, 0, NULL, '2024-03-25 18:38:15.707428', '2024-03-25 18:38:15.707428'),
(2, 1, 2, 1, 0, NULL, '2024-03-25 18:38:15.711243', '2024-03-25 18:38:15.711243');

-- Repeat for 'users' and 'trades' tables including foreign key constraints
-- Make sure to adjust INSERT statements similarly

COMMIT;
