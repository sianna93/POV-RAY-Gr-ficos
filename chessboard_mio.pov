#version 3.7;
global_settings { assumed_gamma 1.2 } 

#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "metals.inc"
#include "glass.inc" 

#include "woods.inc" 


camera {
   location <-5,5,15>//location <-5, 10, -15>
   angle 45 // direction <0, 0,  1.7>
   right x*image_width/image_height
   look_at <6,1,0>
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

plane { <0,1,0> // normal vector
      , 0 // distance from origin
  pigment {
    checker color White, color Gray
  }
}

// DEFINIMOS LA ESFERA
sphere {< 4,0,-1>, 1 texture{pigment{color Blue}finish{ reflection .8 }}
translate<2,1,6> }           

box {< 1,1,1>, <2,2,2> texture{pigment{color Yellow transmit .8 }finish{phong .2}} interior {ior 5.0}
translate<2,0,3>}

//DEFINIMOS LA CAJA

prism{ 0.00, 1.00, 4,
       <-1.00,0.00>, <1.00,0.00>, <0.00,-1.30>, <-1.00,0.00> 
      rotate<90,0,0>

translate<3,0,6>
texture{pigment{color Red transmit .3 }finish{metallic .5}} 
//rotate <0,20,0> //Rotar 20 grados respecto a eje Y
//El sentido de los giros se hacen usando la regla de la mano izquierda
}                       


//DEFINIMOS EL TOROIDE

torus { 2, 0.4 // radio externo y grosor del toro
translate 1*y //Trasladar 2 unidades en eje Y
texture{pigment{color Green transmit .5 }finish{phong .8}} interior {ior 1.0}
translate <clock, 0, -5>   
translate<0,0,6>
}                                          
     /*
fog{ fog_type 2
      distance  5
      color     White
      fog_offset -5.5
      fog_alt    2.0
      turbulence 1.8
      up <-0.5,1,0>
    }//----------------
 */                   
 
#declare Plastico = finish {
     ambient 0.4
     diffuse 0.45
     reflection 0.15
     phong 0.8
     phong_size 20
      
}

#declare BotellaAgua = object {
  union {
    intersection {
      merge {
        cylinder { < 0, 18.1, 0>
                   < 0, 20  , 0>  0.9 }
        cone     { < 0, 14  , 0>  2.9
                   < 0, 18.1, 0>  0.9 }
        sphere   { < 0, 12.5, 0>  3.3 }
        cylinder { < 0,  0  , 0>
                   < 0, 12  , 0>  3.2 }
      }
      merge {
        cylinder { < 0, 18  , 0>
                   < 0, 20.1, 0>  0.8 }
        cone     { < 0, 13.9, 0>  2.8
                   < 0, 18.0, 0>  0.8 }
        sphere   { < 0, 12.4, 0>  3.2 }
        cylinder { < 0,  6  , 0>
                   < 0, 12.5, 0>  3.1 }
        inverse
      }
      texture { Glass2
        normal {
          bump_map {
            gif "botella_norm.gif"
            map_type 3     //2 Clindro, 3 Toroide
            bump_size 0.5
          }
        }
        scale <15, 15, 15>
      }
   }
   cylinder { < 0, 20, 0>
              < 0, 19, 0> 1.1  // Tapon
       texture {
         pigment {Blue}
         finish { Plastico }
       }  // fin Tapon
   }
  }
}

object { BotellaAgua
   
   scale <0.25,0.25,0.25>
   translate<4,0,6> 
   interior {ior 1.6}
}