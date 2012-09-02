<?php
class demographics_mysqli extends mysqli {
    public function __construct($host, $user, $pass, $db) {
        parent::__construct($host, $user, $pass, $db);

        if (mysqli_connect_error()) {
            die('Connect Error (' . mysqli_connect_errno() . ') '
                    . mysqli_connect_error());
        }
    }

}
$databaseName = 'demographics-test';

$db = new demographics_mysqli('localhost', 'root', 'EMR#$%', $databaseName);

// echo 'Success... ' . $db->host_info . "\n";
echo "databaseName\t table\t field\t type\t collation\t null\t key\t default\t extra\t comment\n";
$resultSet1 = $db->query("show tables");
while($rowValue1 = $resultSet1->fetch_row()) {
set_time_limit(0);

echo "CREATE TABLE `$rowValue1[0]` (\n";
//echo "$rowValue1[0], ";
$resultSet2 = $db->query("show full columns from  ".$rowValue1[0] );

	while($rowValue = $resultSet2->fetch_row()) {
	//                    table          field         type         collation     null            key          default      extra           comment
	//echo "$databaseName\t$rowValue1[0]\t$rowValue[0]\t$rowValue[1]\t$rowValue[2]\t$rowValue[3]\t$rowValue[4]\t$rowValue[5]\t$rowValue[6]\t\"$rowValue[8]\"";
							//break;
	echo "  `$rowValue[0]` $rowValue[1]";
	if($rowValue[3] == "NO") {
		echo " NOT NULL";
	}
	if($rowValue[3] == "YES" && $rowValue[5] === NULL) {
		echo " DEFAULT NULL";
	}
						//echo "\n";
						if(strlen($rowValue[6]) > 0) {
							echo " $rowValue[6]";
						}
						echo ",\n";
						
	}
	echo ");\n\n";
} //close table
$db->close();
?>