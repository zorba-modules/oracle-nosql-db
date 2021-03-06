import module namespace nosql = "http://zorba.io/modules/oracle-nosqldb";
import module namespace base64 = "http://zorba.io/modules/base64";

{
  variable $opt := {
                     "store-name" : "kvstore",
                     "helper-host-ports" : ["localhost:5000"]
                   };
                   
  variable $db := nosql:connect( $opt);
  
  variable $key1 := {
        "major": ["a-tkey1a", "a-tkey1b"], 
        "minor":["mk"]
      };
  
  variable $key2 := { 
        "major": ["a-tkey2a", "a-tkey2b"]
        , 
        "minor":[jn:null()] 
      };
      
  
  variable $ts1 := nosql:put-text($db, $key1, "Value for a-tkey1a/a-tkey1b-mk" );
  variable $valueVer1 := nosql:get-text($db, $key1);
  
  
  variable $ts2 := nosql:put-text($db, $key2, "Value for key2" );
  variable $valueVer21 := nosql:get-text($db, $key2);
  variable $delRes2 := nosql:remove($db, $key2);
  variable $valueVer22 := nosql:get-text($db, $key2);

  (: nosql:disconnect($db); :)

  { 
    "db" : { fn:exists($db) }, 
    "put1 version": { fn:exists($ts1) }, 
    "get1" : { $valueVer1("value") },
    
    "put2": { fn:exists($ts2) },
    "get2": { $valueVer21("value") },
    "del2": { $delRes2 },
    "get2 again": { $valueVer22 }
  }
}

