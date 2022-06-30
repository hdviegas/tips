#MySQL 5.6 hierarchical recursive query. Iterates recursively through a table and process the results.

SELECT @pv := id AS id, name,
  (SELECT count(*)
   FROM
     (SELECT *
      FROM users
      ORDER BY parent, id) x
   WHERE find_in_set(parent, @pv)
     AND length(@pv := concat(@pv, ',', id)) ) AS users_count
FROM users AS u
WHERE parent IS NULL

# Table DDL ------------------------------------

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

INSERT INTO `users` (name,parent) VALUES
	 ('top',NULL),
	 ('sub 1',NULL),
	 ('sub 1 - 2',1),
	 ('sub 2 ',2),
	 ('sub 2 - 1',3),
	 ('sub 3',4),
	 ('sub 4',6),
	 ('sub 5',7);
