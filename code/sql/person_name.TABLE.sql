delimiter $$

CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `person_last_name` varchar(255) DEFAULT NULL,
  `person_first_name` varchar(255) DEFAULT NULL,
  `person_MI` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '[Values: Maiden Name, Married Name, Other]',
  PRIMARY KEY (`person_name_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `person_name_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1$$

