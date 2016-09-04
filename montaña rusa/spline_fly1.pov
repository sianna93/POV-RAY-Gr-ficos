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
#include "spline_fly_texturas.inc"
//------------------------------------------------------------------------
#declare Camera_1 = camera { 
                             angle 60
                             location  <6.0 , 6.0 ,-10.0>
                             right     x*image_width/image_height
                             look_at   <0.8 , 2.5 , 0.0>
                           }
camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<-1000,2500,-2500> color White}


/*// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere 
//------------------------------------------------------------------------   */

      
       
  



// sky ----------------------------------
sky_sphere{
    #if(clock<0.4)
        
        pigment{cielo_azul}
        pigment{textura_nubes} 
    
    #end
        
    #if(clock>0.4 & clock <0.7)
       
       pigment{textura_atardecer}
    #end
    
    #if(clock >=0.7)
       
       pigment{cielo_azul}
    #end
 

 
 
} // end sky_sphere ---------------------     
   





        
/*
//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis( AxisLen, Dark_Texture,Light_Texture) 
 union{
    cylinder { <0,-AxisLen,0>,<0,AxisLen,0>,0.05
               texture{checker texture{Dark_Texture } 
                               texture{Light_Texture}
                       translate<0.1,0,0.1>}
             }
    cone{<0,AxisLen,0>,0.2,<0,AxisLen+0.7,0>,0
          texture{Dark_Texture}
         }
     } // end of union                   
#end // of macro "Axis()"
//------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes --------------------------------
union{
#if (AxisLenX != 0)
 object { Axis(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          scale 0.5 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
           scale 0.5 translate <-0.3,AxisLenY+0.50,-0.10>}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.35,0.2,AxisLenZ+0.10>}
#end // of #if 
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{color rgb<1,0.35,0>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{color rgb<1,1,1>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }

object{ AxisXYZ( 4.5, 5.4, 6, Texture_A_Dark, Texture_A_Light)}
//-------------------------------------------------- end of coordinate axes 

*/ 


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.025;  
#declare RasterHalfLineZ = 0.025; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<0,0,0,0>]
                          [0+HLine color rgbt<0,0,0,0>]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<0,0,0,0>]
                          [1.000   color rgbt<0,0,0,0>]} }
       finish { ambient 0.15 diffuse 0.85}
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    



//Se inicializan variables necesarias para el piso



//----------- AGUA AZUL ------------------------ 
#if (clock<=0.4)
    #declare piso_fog=piso_fog_agua;
    #declare piso_plano=piso_plano_blue;
#end

//------------------AGUA----------------------
#if (clock>0.4 & clock <0.7)
    #declare piso_fog=piso_fog_agua;
    #declare piso_plano=piso_plano_agua;
#end

// ---------- NIEVE --------------------------
#if(clock>=0.7)
    #declare piso_fog=piso_fog_nieve;
    #declare piso_plano=piso_plano_nieve; 
#end

//se añade el piso
fog{piso_fog}
object{piso_plano}
      

//REFERENCIA: http://www.f-lohmueller.de/pov_tut/animate/anim22e.htm
//--------------------------------------------------------------------------
//---------------------------   scenery objects  ---------------------------
//--------------------------------------------------------------------------

// ****** SPLINE 1*********
//#declare MyArray = array[10]
#declare N = 10;

#declare P = array[10];// start with zero!

#declare P[0] = <-2.70, 0.5, -2.00>; 
#declare P[1] = <-2.00, 1.15, -1.80>;
#declare P[2] = <-0.50, 1.10, -2.00>;
#declare P[3] = < 1.50, 0.60, -2.50>;
#declare P[4] = < 2.00, 0.45, -2.00>;

#declare P[5] = < 4.00, 0.75, -1.00>;
#declare P[6] = < 4.00, 2.25,  4.00>;
#declare P[7] = < 0.00, 1.15,  4.00>;
#declare P[8] = <-4.00, 2.25,  3.50>;
#declare P[9]=  <-4.00, 1.00, -1.00>;

#declare Spline_1 =
  spline {
    natural_spline
   -0.200, P[8],
   -0.050, P[9],
    0.000, P[0], // start
    0.050, P[1], 
    0.100, P[2], 
    0.170, P[3], 
    0.220, P[4],

    0.300, P[5],
    0.490, P[6],
    0.580, P[7],
    0.800, P[8],
    0.950, P[9],
    1.000, P[0], // end at start
    1.050, P[1]
    1.100, P[2]
  }

//----------------------------------------------- the spline curve ---------- 


// ****** SPLINE 2*********
//#declare MyArray = array[10]
#declare N2 = 10;

#declare P2 = array[10];// start with zero!

#declare P2[0] = <-2.70, 2.5, -2.00>; 
#declare P2[1] = <-2.00, 3.15, -1.80>;
#declare P2[2] = <-0.50, 3.10, -2.00>;
#declare P2[3] = < 1.50, 2.60, -2.50>;
#declare P2[4] = < 2.00, 2.45, -2.00>;

#declare P2[5] = < 4.00, 2.75, -1.00>;
#declare P2[6] = < 4.00, 4.25,  4.00>;
#declare P2[7] = < 0.00, 3.15,  4.00>;
#declare P2[8] = <-4.00, 4.25,  3.50>;
#declare P2[9]=  <-4.00, 3.00, -1.00>;
          
#declare Spline_2 =
  spline {
    natural_spline
   -0.200, P2[8],
   -0.050, P2[9],
    0.000, P2[0], // start
    0.050, P2[1], 
    0.100, P2[2], 
    0.170, P2[3], 
    0.220, P2[4],

    0.300, P2[5],
    0.490, P2[6],
    0.580, P2[7],
    0.800, P2[8],
    0.950, P2[9],
    1.000, P2[0], // end at start
    1.050, P2[1]
    1.100, P2[2]
  }

//----------------------------------------------- the spline curve ----------
#declare montaine_rusa=
union{
 #declare Nr = 0;     // start
 #declare EndNr = 1; // end  
 
 #declare block=0;
 #while (Nr< EndNr) 

 /*sphere{ <0,0,0>,0.05
	 texture{ pigment{color rgb <1-2*Nr/3,0.75+Nr/4,0>}
	          finish {ambient 0.15 diffuse 0.85 phong 1}
                }
         translate Spline_1(Nr) 
       } // end of sphere  */
 
 
 box {< 0.15,0.1,0.3>, <0.01,0.1,0.01>
    texture{ pigment{color rgb <1-2*Nr/3,1.75+Nr/4,0.2>}
	          finish {ambient 0.15 diffuse 0.85 phong 1}
                }
         translate Spline_1(Nr) 
       }               
 
 
 cylinder { <0,0,0>,<0,-Spline_1(Nr).y,0>,0.02 
           texture { pigment { color rgb<0.40,0.25,0.15>}
                     normal  { bumps 0.5 scale <0.005,0.25,0.005>}
                     finish  { ambient 0.15 diffuse 0.85 phong 0.5}
                   } // end of texture
           translate Spline_1(Nr) 
         } // end of cylinder   
 
 
 #if(block=0)
    box {< 0.15,0.02,0.15>, <0.01,0.1,0.01>
    texture{ pigment{color rgb <0.317,0.258,0.203>}
	          finish {ambient 0.15 diffuse 0.85 phong 1}
                }
         translate <Spline_1(Nr).x-0.25,-0.02,Spline_1(Nr).z-0.125> 
       }
   #declare block=1;
 
 #else
    box {< 0.15,0.02,0.15>, <0.01,0.1,0.01>
    /*texture{ pigment{color rgb <0.745,0.745,0.745>}
	          finish {ambient 0.15 diffuse 0.85 phong 1}
                } */
      texture{ crackle  scale 1.5 turbulence 0.1
           texture_map {[0.00 Texture_W]
                        [0.05 Texture_W]
                        [0.05 Texture_S]
                        [1.00 Texture_S]
                       }// end of texture_map
                   scale 0.2
         } // end of texture ---------------------------
         translate <Spline_1(Nr).x-0.25,-0.02,Spline_1(Nr).z-0.125> 
       }
    #declare block=0;
 #end 

 #declare Nr = Nr + 0.01;  // next Nr
 #end // --------------- end of loop 
} // end of union  -----------------------------------------------------------

object{montaine_rusa}    

//----------------------------------------------------------------------------
#declare Jet =                 //---------------------------------------------
union{
cone { <0,0,0>,0.5,<0,0,1.20,>,0 
       texture { pigment{color Silver}
                 finish {ambient 0.05 diffuse 0.85 phong 1}
               } // end of texture
       scale <1,0.1,1> rotate<0,0,0> translate<0,0,0>         
     } // end of cone -------------------------------------------
cone { <0,0,0>,0.05<0,0,-0.30>,0.15 
       texture { pigment{color Silver}
                 finish {ambient 0.1 diffuse 0.8 phong 1}
               } // end of texture
       scale <1,1,1> rotate<0,0,0> translate<0,0,0>         
     } // end of cone -------------------------------------------
sphere { <0,0,0>, 0.15 
         texture { Polished_Chrome
                   finish { ambient 0.1 diffuse 0.85  phong 1}
                 } // end of texture 
          scale<1,0.5,1.5>  rotate<10,0,0>  translate<0,0.10,0.3>  
       }  // end of sphere -------------------------------------- 

scale 0.5
rotate<0,0,0>
}//----------------------------------------------------------- jet fly ----


#declare Nr_j = 0;     // start
#declare EndNr_j = 5; // end
#while (Nr_j< EndNr_j) 

object { Jet scale 1.2
         Spline_Trans (Spline_2,  mod( (clock+Nr_j/EndNr_j) ,1) , y, 0.03, 0.95) }
#declare Nr_j = Nr_j + 1;  // next Nr
#end // --------------- end of loop 

//----------------------------------------------------------------------- end  */  


// ---------------CARRITOOOO---------------------------- ///
#declare piramide_carrito=
union{
    prism{ 0.00, 1.00, 4,
           <-1.00,0.00>, <1.00,0.00>, <0.00,-1.30>, <-1.00,0.00> 
          rotate<90,0,0>
    
        translate<0,0,0>
        texture{pigment{color Red transmit .3 }finish{metallic .5}}   
    }
//rotate <0,20,0> //Rotar 20 grados respecto a eje Y
//El sentido de los giros se hacen usando la regla de la mano izquierda

    /*sphere {< 4,0,-1>, 1 
        texture{pigment{color Blue}finish{ reflection 0.8 }}
        translate<-4,0,4> scale 0.5 rotate <0,0,0>}    */
        
    torus { 0.5,0.05 // radio externo y grosor del toro  
        texture{pigment{color Green transmit .5 }finish{phong .8}} interior {ior 1.0} 
        translate<0.025,0,0.5> rotate <90,0,0>

    }
    torus { 0.5,0.05 // radio externo y grosor del toro  
        texture{pigment{color Green transmit .5 }finish{phong .8}} interior {ior 1.0} 
        translate<0.025,1.05,0.25> rotate <90,0,0>

    }
   
    sphere {<0,0,0>, 0.25 texture{pigment{color Blue}finish{ reflection 0.8 }}
        translate<0.55,1.05,0.85>}
    sphere {<0,0,0>, 0.25 texture{pigment{color Blue}finish{ reflection 0.8 }}
        translate<0.5,1.05,0.25>}    
  translate <0,0.5,-0.65>
  rotate <0,-90,0>
  
}       

/*
#declare Nr_c = 0;     // start
#declare EndNr_c = 10; // end
#while (Nr_c< EndNr_c) 
    #if(clock>=0)
        object { piramide_carrito scale 0.4
         Spline_Trans (Spline_1,  mod( (clock+Nr_c/EndNr_c) ,1) , y, 0.03, 0.95) }
    #end
 #declare Nr_c = Nr_c + 1;  // next Nr 

#end // --------------- end of loop  */
 

#declare Nr_c = 0;     // start
#declare EndNr_c = 5; // end
#while (Nr_c< EndNr_c) 

object { piramide_carrito scale 0.4
         Spline_Trans (Spline_1,  mod( (clock*0.5+Nr_c/EndNr_c) ,1) , y, 0.03, 0.95) }
#declare Nr_c = Nr_c + 1;  // next Nr
#end // --------------- end of loop 

//----------------------------------------------------------------------- end  */  


//----------------------------------------------------------------------- end  */ 