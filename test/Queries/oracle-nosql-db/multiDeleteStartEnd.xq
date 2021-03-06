import module namespace nosql = "http://zorba.io/modules/oracle-nosqldb";
import module namespace base64 = "http://zorba.io/modules/base64";

{
  variable $opt := {
                     "store-name" : "kvstore",
                     "helper-host-ports" : ["localhost:5000"]
                   };
                   
  variable $db := nosql:connect( $opt);
  
  variable $key1 := {
        "major": ["mDSE1", "mDSE2"], 
        "minor":["m1"]
      };
  
  variable $key2 := {
        "major": ["mDSE1", "mDSE2"], 
        "minor":["m2"]
      };
      
  variable $key31 := {
        "major": ["mDSE1", "mDSE2"], 
        "minor":["m3", "m31"]
      };

  variable $key32 := {
        "major": ["mDSE1", "mDSE2"], 
        "minor":["m3", "m32"]
      };

  variable $key4 := {
        "major": ["mDSE1", "mDSE2"], 
        "minor":["m4", "a", "b"]
      };

  nosql:put-text($db, $key1, "V m1" );
  nosql:put-text($db, $key2, "V m2" );
  nosql:put-text($db, $key31, "V m31" );
  nosql:put-text($db, $key32, "V m32" );
  nosql:put-text($db, $key4, "V m4 a b" );

  variable $parentKey := {"major": ["mDSE1", "mDSE2"] };

  variable $md1 := nosql:multi-remove($db, $parentKey, { "start" : "a", "end": "b" }, "PARENT_AND_DESCENDANTS");

  variable $g1 := nosql:get-text($db, $key1);

  variable $md2 := nosql:multi-remove($db, $parentKey, { "start" : "m3", "end": "m4" }, "PARENT_AND_DESCENDANTS");

  variable $g2 := nosql:get-text($db, $key1);

  variable $md3 := nosql:multi-remove($db, $parentKey, { "start" : "a", "end" : "z" }, "PARENT_AND_DESCENDANTS");

  variable $g3 := nosql:get-text($db, $key1);


  (: nosql:disconnect($db); :)

  { 
    "md1": {$md1}, 
    "g1": {$g1("value")},
    "md2": {$md2}, 
    "g2": {$g2("value")},
    "md3": {$md3}, 
    "g3": {$g3}
  }
}

