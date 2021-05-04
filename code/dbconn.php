<?php

class DBconnection{
    static $database_name = 'FANNI';
    public static $conn = null;
    private static $instance = null;

    private function __construct(){
        $connection = oci_connect('ADMIN', 'webshop','localhost/XE', "UTF8") or die("Hibás csatlakozás!");
        // a karakterek helyes megjelenítése miatt be kell állítani a karakterkódolást!
        if(!$connection){
            $m = oci_error();
            echo $m['message'], "\n";
            exit;
        }else {
            print "Connected to Oracle!";
        }
        self::$conn = $connection;
    }

    public function getConnection(){
        return self::$conn;
    }


    public static function getInstance(){
        if(self::$instance==null){
            self::$instance= new DBConnection();
        }
        return self::$instance;
}

    function disconnectDB(){
        oci_close($this->conn); // lezárjuk az adatbázis-kapcsolatot
    }

    function getErrorMessage(){
        return mysqli_error($this->conn);
    }

    function insertInto($table_name, $arguments){
        //$arguments: kulcs-érték pár, ahol a kulcs az adatbázis mezője,
        //az érték pedig az adatbázisban a mező értéke
        $query = "INSERT INTO {$table_name} (";
        foreach($arguments as $key=>$value){
            $query.="$key";
            end($arguments);         // move the internal pointer to the end of the array
            $lastkey = key($arguments);  // fetches the key of the element pointed to by the internal pointer

            if($lastkey==$key){
            }else{
                $query.=", ";
            }
        }
        $query.=") VALUES (";
        foreach($arguments as $key=>$value){
            $query=$query."'$value'";
            end($arguments);         // move the internal pointer to the end of the array
            $lastkey = key($arguments);  // fetches the key of the element pointed to by the internal pointer

            if($lastkey==$key){
            }else{
                $query.=", ";
            }
        }
        $query.=")";
        //echo $query;
        $stid= oci_parse($this->conn, $query);
        //echo "<br>stid: ".$stid."<br>";
        $r =oci_execute($stid, OCI_NO_AUTO_COMMIT);
        echo $query;
        if(!$r){
            oci_rollback($this->conn);
            echo oci_error($this->conn);
        }
        echo $r."<br>";
        return $r;
    }

    function parseQuery($query){
        //echo $query;
        $stid=oci_parse($this->conn, $query);
        return $stid;
    }

    function select($oszloplista, $tablalista, $feltetelek){
        //megvalósítja a SELECT SQL utasítást
        //$oszloplista megadja a megjelenítendő oszlopokat
        //$tablalista megadja a megjelenítendő táblákat (ezekből lesz "Descartes-szorzat" - Németh Gábor)
        //$feltetelek string, szűrési feltételeket ad meg
        $query = "SELECT ";
        for($i=0;$i<sizeof($oszloplista);$i++){
            $o=$oszloplista[$i];
            $query.=$o;
            if($o!=end($oszloplista)){
                $query.=", ";
            }
        }
        $query.=" FROM ";
        foreach($tablalista as $o){
            $query.=$o;
            if($o!=end($tablalista)){
                $query.=" , ";
            }
        }
        if($feltetelek!=null){
            $query.=" WHERE {$feltetelek}";
        }
        //echo $query;
        $stid=oci_parse($this->conn, $query);
        return $stid;
    }

    function update(){

    }

    function deleteFrom($table, $where){
        echo "DELETE FROM ".$table." WHERE ".$where.";<br>";
        $stid=$this->parseQuery("DELETE FROM ".$table." WHERE ".$where);
        $r =  oci_execute($stid, OCI_NO_AUTO_COMMIT);
        if(!$r){
            oci_rollback($this->conn);
            echo oci_error($this->conn);
        }
        return $r;
    }

}