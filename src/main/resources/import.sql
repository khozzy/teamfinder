# Startup data

ALTER TABLE `user` CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;

## Users
INSERT INTO `user` (id, created_date, name, surname, email, password, city, street, house_number, about) VALUES
  (1, NOW(), 'Admin', 'Adminowy', 'admin@admin.pl', '$2a$10$Bdbq653hfPq2li9p/.6htO/fySa6OI90ZhtreuEUtyI9RpdtHRTqK','Wrocław', 'Sienkiewicza', '30/21', 'Tutaj jakieś informacje o mnie'),
  (2, NOW(), 'Krzysiek', 'Milecki', 'kmilecki@user.pl', '$2a$10$Bdbq653hfPq2li9p/.6htO/fySa6OI90ZhtreuEUtyI9RpdtHRTqK', 'Wrocław', 'Sienkiewicza', '30/44', 'O mnie ...'),
  (3, NOW(), 'Bartek', 'Bogucki', 'bbogucki@user.pl', '$2a$10$Bdbq653hfPq2li9p/.6htO/fySa6OI90ZhtreuEUtyI9RpdtHRTqK', 'Wrocław', 'Chorwacka', '30/144', 'O mnie ...'),
  (4, NOW(), 'Roberto', 'Sanchez', 'rsanchze@user.pl', '$2a$10$Bdbq653hfPq2li9p/.6htO/fySa6OI90ZhtreuEUtyI9RpdtHRTqK', 'Wrocław', 'Rynek', '4/441', 'O mnie ...'),
  (5, NOW(), 'Maciek', 'Gruzer', 'mgruzer@user.pl', '$2a$10$Bdbq653hfPq2li9p/.6htO/fySa6OI90ZhtreuEUtyI9RpdtHRTqK', 'Wrocław', 'Jugosławiańska', '43/2m', 'O mnie ...'),
  (6, NOW(), 'Maciek', 'Gol', 'mac_3@op.pl', '$2a$10$oapB1czPgR9hzQlglCLWueuZzKAbIf3HQJ2GArEff3b4tNzGp7hCO', 'Wrocław', 'Wittiga', '43/2m', 'O mnie ...'),
  (7, NOW(), 'Michał', 'W', 'mic11w@gmail.com', '$2a$10$QhP7VXcS/yNGlHZ0jOrLzezqhFidSuoTw/PfjMDpOSnKzIPInYyvK', 'Wrocław', 'Wittiga', '43/2m', 'O mnie ...');

# Roles
INSERT INTO `user_roles` (user_id, roles) VALUES
  (1, 'ADMIN'),
  (2, 'NORMAL_USER'),
  (3, 'NORMAL_USER'),
  (4, 'PLACE_OWNER'),
  (5, 'NORMAL_USER'),
  (6, 'NORMAL_USER'),
  (7, 'NORMAL_USER');

## Teams
  INSERT INTO `suspy`.`team` (`id`, `created_date`, `deleted`, `name`, `leader_id`) VALUES
  ('1', '1990-10-10', 0, '90ties kids', '1'),
  ('2', NOW(), 0, 'Wittigowo', '2'),
  ('3', '1990-10-10', 0, 'Univerki', '3'),
  ('4', NOW(), 0, 'WrocStud', '4');

# User Teams
  INSERT INTO `suspy`.`user_team` (`user_id`, `team_id`) VALUES
  ('1', '1'), ('2', '1'),  ('3', '1'),
  ('1', '2'), ('2', '2'),
#  ('1', '3'), ('3', '3'),
  ('3', '3'),
  ('1', '4'),  ('3', '4'),  ('4', '4');

# Observation
  INSERT INTO `suspy`.`observation` (`user_id`, `observing_user_id`) VALUES
  ('1', '2'), ('1', '3'), ('1', '4'), ('1', '5'),
  ('2', '5'), ('2', '3'),
  ('3', '5'),
  ('4', '5'),('4', '1'),('4', '3'),
  ('5', '1');

## Places
INSERT INTO `suspy`.`place` (`id`, `created_date`, `deleted`, `accepted`, `city`, `house_number`, `street`, `capacity`, `name`, `owner_id`) VALUES
  ('1', NOW(), false, true , 'Internet', '99', 'League of Legends', '10', 'Games: League of Legends', '1'),
  ('2', NOW(), false, true , 'Wroclaw', '60', 'Wittiga', '100', 'Boisko Akademiki', '1'),
  ('3', NOW(), false, true , 'Przeworsk', '60', 'Mickiewicza', '50', 'Basen', '1'),
  ('4', NOW(), false, true , 'Warszawa', '60', 'Alicjanowicza', '20', 'Hala sportowa 1', '1'),
  ('5', NOW(), false, true , 'Warszawa', '60', 'Alicjanowicza', '20', 'Hala sportowa 2', '1'),
  ('6', NOW(), false, true , 'Warszawa', '60', 'Alicjanowicza', '20', 'Hala sportowa 3', '6'),
  ('7', NOW(), false, true , 'Milanowice', '60', 'Slowackiego', '100', 'Stadion', '1'),
  ('8', NOW(), false, true , 'Wroclaw', '60', 'Chrobrego', '100', 'Basen', '1'),
  ('9', NOW(), false, true , 'Wroclaw', '60', 'Chrobrego', '20', 'Boisko do koszykowki', '6'),
  ('10', NOW(), false, true , 'Wroclaw', '60', 'Chrobrego', '40', 'Orlik', '1');

#Places activity (TODO)

#Time Slots
  INSERT INTO `suspy`.`time_slot` (`id`, `created_date`, `deleted`, `date_from`, `price`, `date_to`, `place_id`,`paid`) VALUES
  ('1', NOW(), 0, NOW(), '100', '2015-01-01', '1',0),
  ('2', NOW(), 0, NOW(), '111', '2015-02-02', '2',0),
  ('3', NOW(), 0, NOW(), '222', '2015-03-03', '3',0),
  ('4', NOW(), 0, NOW(), '333', '2015-04-04', '4',0),
  ('5', NOW(), 0, NOW(), '444', '2015-05-06', '5',0),
  ('6', '2000-05-06', 0, '2014-05-06', '444', '2014-06-06', '6',0),
  ('7', '2010-05-06', 0, '2013-05-06', '2000', '2014-06-08', '7',0),
  ('8', '2010-05-06', 0, '2014-11-11', '40', '2014-12-12', '7',0);

## Event
INSERT INTO `suspy`.`event` (`id`, `created_date`, `deleted`, `name`, `event_details` ,`priv`, `organizer`, `team_id` , `time_slot_id`) VALUES
('1', '2000-01-01', 0, 'Niedzielna gra', 'Chcesz sobie pograc w niedziele? Idealnie trafiles!', 0, '1', '1', '1'),
('2', '2000-01-01', 0, 'Ja gra', 'Gram ja i to wystarczy.', 0, '1', '2', '2'),
('3', '2000-01-01', 0, 'Kosz', 'Idziemy pograc w kosza ze znajomymi z dzielni', 0, '2', '1', '3'),
('4', '2000-01-01', 0, 'Reczna', 'Czy jestes na tyle wytwaly zeby pilke reka rzucac ?', 0, '2', '3', '4'),
('5', '2000-01-01', 0, 'tenis', 'Pilka zielona, jedna siata, dwie rakiety tylko my we dwoje .....', 0, '2', '4', '5'),
('6', '2000-01-01', 0, 'MASAKRYCZNA GRA', 'Bedzie hardcore', 0, '4', '1', '6');