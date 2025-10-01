INSERT INTO users (username, password, enabled) VALUES
  ('admin', '$2a$10$N9qo8uLOickgx2ZMRZo5i.Ur07XH8VEWil/92pT9bkHYOEqf9Wl16', TRUE);

INSERT INTO authorities (username, authority) VALUES
  ('admin', 'ROLE_USER'),
  ('admin', 'ROLE_ADMIN');
