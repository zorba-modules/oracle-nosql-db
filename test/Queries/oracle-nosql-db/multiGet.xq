import module namespace nosql = "http://zorba.io/modules/oracle-nosqldb";
import module namespace base64 = "http://zorba.io/modules/base64";

{
  variable $opt := {
                     "store-name" : "kvstore",
                     "helper-host-ports" : ["localhost:5000"]
                   };
                   
  variable $db := nosql:connect( $opt);
  
  variable $key1 := {
        "major": ["M1", "M2"], 
        "minor":["m1"]
      };
  
  variable $key2 := {
        "major": ["M1", "M2"], 
        "minor":["m2"]
      };
      
  variable $key31 := {
        "major": ["M1", "M2"], 
        "minor":["m3", "m31"]
      };

  variable $key32 := {
        "major": ["M1", "M2"], 
        "minor":["m3", "m32"]
      };

  variable $key4 := {
        "major": ["M1", "M2"], 
        "minor":["m4", "a", "b"]
      };

  nosql:put-text($db, $key1, "V m1" );
  nosql:put-text($db, $key2, "V m2" );
  nosql:put-text($db, $key31, "V m31" );
  nosql:put-text($db, $key32, "V m32" );
  nosql:put-text($db, $key4, "V m4 a b" );

  variable $parentKey := {"major": ["M1", "M2"] };


  variable $mg1 := nosql:multi-get-text($db, $parentKey, { "start" : "a", "end": "b" }, "PARENT_AND_DESCENDANTS", "FORWARD");

  variable $mg2 := nosql:multi-get-text($db, $parentKey, { "start" : "m3", "end": "m4" }, "PARENT_AND_DESCENDANTS", "FORWARD");

  variable $mg3 := nosql:multi-get-text($db, $parentKey, { "start" : "a", "end" : "z" }, "PARENT_AND_DESCENDANTS", "FORWARD");


  (: nosql:disconnect($db); :)

  { 
    "mg1": { $mg1 }, 
    "mg2": { $mg2("value") }, 
    "mg3": { $mg3("value") } 
  }
}

