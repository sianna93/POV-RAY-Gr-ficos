//// __ DESARROLLADO ____ ///////////////
//SIANNA PUENTE
//ADRIANO PINARGOTE
//JULIO LARREA

//------------------------------------------------------------------------
#version 3.7;
global_settings {  assumed_gamma 1.0 }
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "stones.inc"

#include "transforms.inc"

//CIELO
////Referencia: http://www.povray.org/documentation/view/3.7.0/77/
#declare textura_atardecer=  
    pigment{ gradient <0,1,0>
              color_map{
         [0.00 color rgb<0.24,0.32,1> *0.3]
         [0.23 color rgb<0.16,0.32,0.9> *0.9]
         [0.37 color rgb<1,0.1,0> ]
         [0.52 color rgb<1,0.2,0> ]
         [0.70 color rgb<0.36,0.32,1> *0.7 ]
         [0.80 color rgb<0.14,0.32,1> *0.5 ]
         [1.00 color rgb<0.24,0.32,1> *0.3 ]
                       } // end color_map  */
        
     scale 2
     rotate <-20,0,0>
     translate <0,0.7,0>
    } // end pigment
    
#declare textura_nubes=
    pigment {
      agate
      turbulence 1
      lambda 2
      frequency 0.5
      color_map {
        [0.0 color rgbf <1, 1, 1, 1>]
        [0.5 color rgbf <1, 1, 1, .35>]
        [1.0 color rgbf <1, 1, 1, 1>]
      }
    
     scale 2
     rotate <-20,0,0>
     translate <0,0.7,0>
    } // end pigment  
    
#declare textura_noche=
    pigment{
    image_map{ jpeg "stars.jpg"
               //gamma 1.1
               map_type 1 interpolate 2 once
             }
    
    
    //scale 100
    //rotate <-20,0,0>
    translate <0.7,0.7,0.7>

      }// end pigment

#declare cielo_azul_nubes=   
    sphere{ <0,0,0>,1 hollow  // 
        // layered textures:
        texture{ pigment{ color rgb<0.1,0.3,0.75>*0.6}
                 #if (version = 3.7 )  finish {emission 1 diffuse 0}
                 #else                 finish { ambient 1 diffuse 0}
                 #end 
               } // end texture 1
    
        texture{ pigment { bozo turbulence 0.65
                           octaves 6  omega 0.7 lambda 2 
                           color_map { 
                        [0.0  color rgb <0.95, 0.95, 0.95>*0.5 ]
                        [0.1  color rgb <1, 1, 1>*1.1 ]
                        [0.15 color rgb <0.85, 0.85, 0.85> ]
                        [0.5 color rgbt <1, 1, 1, 1>*1 ]
                        [1.0 color rgbt <1, 1, 1, 1>*1 ]
                            } // end color_map
                           rotate<10,23,0>
                           scale <0.3, 0.4, 0.2>*0.7
                         } // end pigment
                 #if (version = 3.7 )  finish {emission 1 diffuse 0}
                 #else                 finish { ambient 1 diffuse 0}
                 #end 
               } // end texture 2
                      
     scale 10000}

#declare cielo_azul=
    pigment{ color rgb<0.1,0.3,0.75>*0.6}
        

//PISO

//REFERENCIA: http://www.f-lohmueller.de/pov_tut/plants/plants_00f.htm
//nieve     
#declare piso_fog_nieve= 
    // fog on the ground -------------------------------------------------
    fog { fog_type   2
          distance   50
          color      White*0.75
          fog_offset 0.1
          fog_alt    1.5
          turbulence 1.8
        }                                                    // end of fog
#declare piso_plano_nieve=    
    // ground ------------------------------------------------------------
    plane { <0,1,0>, 0 
            texture{ pigment{ color rgb<1,1,1>*1.2}//0.35,0.65,0.0>*0.45 }
                     normal { bumps 0.75 scale 0.125  }
                     finish { phong 1 }
                   } // end of texture
          } // end of plane                                   // end of ground     


/************** Plano Agua ***************************/ 

//REFERENCIA: http://www.f-lohmueller.de/pov_tut/backgrnd/p_wat1.htm


#declare piso_fog_agua=
    // fog ---------------------------------------------------------------
    fog{fog_type   2   distance 65  color rgb<1,0.99,0.9>
        fog_offset 0.1 fog_alt  2.0 turbulence 0.2}
    //--------------------------------------------------------------------

#declare piso_plano_agua=    
    plane{<0,1,0>, 0 
          texture{pigment{ rgb <0.01, 0.02, 0.2> } 
                  normal { bumps 0.08 scale <1,0.25,0.35>*1 turbulence 0.3 }
                  finish { ambient 0.05 diffuse 0.55 
                           brilliance 6.0 phong 0.8 phong_size 120
                           reflection 0.6 }
                 }
         }

#declare piso_plano_blue=
    plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color Blue*0.3}
                  finish {ambient 0.45 diffuse 0.85 reflection 0.4
                          brilliance 6.0 phong 0.8 phong_size 120}}         
        rotate<0,0,0>
      }



///
//////////////// TEXTURA ROCA /////////////////////////

#declare Texture_W =
 texture{ pigment{ color White*0.9}
          normal { bumps 1 scale 0.0025}
          finish { diffuse 0.9 specular 1}
        } // end of texture
#declare Texture_S =
 texture{ T_Stone10 scale 1
          normal { agate 0.5 scale 0.025}
          finish { diffuse 0.9 phong 1 }
        } // end of texture