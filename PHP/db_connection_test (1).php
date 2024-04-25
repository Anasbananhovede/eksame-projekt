    <?php
		function OpenConnPDO()
		{
			$db_host = "mysql111.unoeuro.com";
			$db_name = "monkeypaw17_dk_db";
			$db_username = "monkeypaw17_dk";
			$db_password = "6fc3BawxnpryH4D9kdRE";

			#Set up logindata for PDO
			$dsn = "mysql:dbname=$db_name;host=$db_host;charset=utf8mb4;port=3306";			
			
			#Attempt connection and catch error
			try{
				$pdo = new PDO($dsn, $db_username, $db_password); 	
			}
			catch (\PDOException $e){
				print_response("no_return", [], "db_login_error");
				die;
			}
			
			return $pdo;
		}
		
		function CloseConnPDO($pdo)
		{
			//$pdo -> close();
		}
    ?>
	