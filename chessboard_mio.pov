#version 3.7;
global_settings { assumed_gamma 1.2 } 

#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "metals.inc"
#include "glass.inc"
#include "woods.inc"

camera {
   location <-5,10,-5>//location <-5, 10, -15>
   angle 45 // direction <0, 0,  1.7>
   right x*image_width/image_height
   look_at <0,0,0>
}

// Uncomment the area lights only if you've got lots of time.
#declare Dist=160.0;
light_source {< -50, 25, -50> color White
     fade_distance Dist fade_power 2
//   area_light <-40, 0, -40>, <40, 0, 40>, 3, 3
//   adaptive 1
//   jitter
}
light_source {< 50, 10,  -4> color Gray30
     fade_distance Dist fade_power 2
//   area_light <-20, 0, -20>, <20, 0, 20>, 3, 3
//   adaptive 1
//   jitter
}
light_source {< 0, 100,  0> color Gray30
     fade_distance Dist fade_power 2
//   area_light <-30, 0, -30>, <30, 0, 30>, 3, 3
//   adaptive 1
//   jitter
}

//LINK REFERENCIA: http://www.f-lohmueller.de/pov_tut/x_sam/sam_420e.htm
#declare Chessboard =
union{
 box {<-1,-0.1,-1>,<1,0,1>
      texture{
        pigment{
          color rgb<0.5,0,0.5>*0.5}
             } // end of texture
    } // end of box ----------------------
 box {<-1.00,0.00,-1.00>,<1.00,0.1,1.00>
      texture{
        pigment{ checker
                 color rgb<1,1,1>
                 color rgb<0,0,0>
               } // end pigment
               scale 0.25
             } // end of texture
    } // end of box ----------------------
} // ---------------- end union Chessbord

// using:
//------------------------------
object{ Chessboard
        translate<0,0,0>
        scale 2.5
        rotate<0,0,0>
      } // ------------------
//-------------------------------
