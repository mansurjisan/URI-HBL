  �  "   k820309    ,          2021.5.0    tXd                                                                                                          
       /projects/ees/dhs-crc/mjisan/HBL_V_DEV5/INIT/boundary_home/source/parametric/land_roughness_mod.F90 LAND_ROUGHNESS_MOD              LAND_ROUGHNESS                      @                              
       MASTER RANK                      @                              
       STDOUT ERROR_HANDLER GET_UNIT_NUM                      @                              
       GET_FILE_DIMS                      @                              
       BILINEAR_INTERP PAIR                      @                              
       MPP_READ_AXES MPP_READ_DATA                                                     
       NX NY                                                     
       REARTH DEG2RAD                 @� @                              
       R4 SHR_KIND_R4 R8 SHR_KIND_R8               @�                                      u #MPP_READ_DATA_2D 	   #MPP_READ_DATA_0D    #         @     @                           	                    #DATA_OUT 
   #DATA_NAME    #DATA_FILE    #IM    #JM    #NREC                                             
                    	       p        5 O p        p          5 O p          5 O p            5 O p          5 O p                                    
                                                    1           
                                                    1           
                        @                              
                        @                              
                                            #         @     @                                                #DATA_OUT    #DATA_NAME    #DATA_FILE    #NREC                                                   	                 
                                                    1           
                                                    1           
                                                            @  @                                '                    #LO    #UP                 � $                                                              � $                                                #         @                                                       #LAND_ROUGH    #LAND_MASK    #XGRID    #YGRID    #XCEN    #YCEN    #STORM_NAME              D @                                   Q~1            	     p 
        p 	        p 	          p 	        p 	                                  
                                      Q~1            	    p 
        p 	        p 	          p 	        p 	                                  
  @                                   	             	    p          p 	          p 	                                  
  @                                   	             	 	   p          p 	          p 	                                  
                                      	                
                                      	                
  @                                                             �         fn#fn (        b   uapp(LAND_ROUGHNESS_MOD    >  L   J  MPP_SETUP_MOD    �  b   J  MPP_IO_MOD !   �  N   J  MPP_IO_UTILS_MOD $   :  U   J  BILINEAR_INTERP_MOD    �  \   J  MPP_READ_MOD    �  F   J  GRID_MOD    1  O   J  CONSTANTS_MOD    �  ^   J  SHR_KIND_MOD /   �  l       gen@MPP_READ_DATA+MPP_READ_MOD .   J  �      MPP_READ_DATA_2D+MPP_READ_MOD 7   �  �   a   MPP_READ_DATA_2D%DATA_OUT+MPP_READ_MOD 8   �  L   a   MPP_READ_DATA_2D%DATA_NAME+MPP_READ_MOD 8      L   a   MPP_READ_DATA_2D%DATA_FILE+MPP_READ_MOD 1   l  @   a   MPP_READ_DATA_2D%IM+MPP_READ_MOD 1   �  @   a   MPP_READ_DATA_2D%JM+MPP_READ_MOD 3   �  @   a   MPP_READ_DATA_2D%NREC+MPP_READ_MOD .   ,  ~      MPP_READ_DATA_0D+MPP_READ_MOD 7   �  @   a   MPP_READ_DATA_0D%DATA_OUT+MPP_READ_MOD 8   �  L   a   MPP_READ_DATA_0D%DATA_NAME+MPP_READ_MOD 8   6  L   a   MPP_READ_DATA_0D%DATA_FILE+MPP_READ_MOD 3   �  @   a   MPP_READ_DATA_0D%NREC+MPP_READ_MOD )   �  `      PAIR+BILINEAR_INTERP_MOD ,   "	  H   a   PAIR%LO+BILINEAR_INTERP_MOD ,   j	  H   a   PAIR%UP+BILINEAR_INTERP_MOD    �	  �       LAND_ROUGHNESS *   S
  �   a   LAND_ROUGHNESS%LAND_ROUGH )     �   a   LAND_ROUGHNESS%LAND_MASK %   �  �   a   LAND_ROUGHNESS%XGRID %   O  �   a   LAND_ROUGHNESS%YGRID $   �  @   a   LAND_ROUGHNESS%XCEN $   #  @   a   LAND_ROUGHNESS%YCEN *   c  P   a   LAND_ROUGHNESS%STORM_NAME 