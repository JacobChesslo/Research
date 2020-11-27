#!/bin/sh

#  Gridpack.sh
#  
#
#  Created by Jacob Chesslo on 11/12/20.
#

        # temp_dir = ${template_dir[$j]}
        
#inside of MadGraph5_aMCatNLO of genproductions/bin/

#model folders are in /production


#models being produced
models=('ZDfD' 'ZDsD' 'ZDfDsD')
DMmodels=('DM_KinMix_Med_Spin1_Fermionic_Prds.gz' 'DM_KinMix_Med_Spin1_Scalar_Prds.gz' 'DM_KinMix_Med_Spin1_Fermionic_Scalar_Prds.gz')

#particles in all models, standard masses for them
particles=('ZD' 'fD1' 'fD2' 'sD')
std_particle_mass=(500 5 2 5)

#decay modes
decay=('p p > ZD, (ZD > FD11 FD11, (FD11 > FD21 mu+ mu-))' 'p p > ZD, (ZD > SD SD~, SD > mu+ mu-, SD~ > mu+ mu-)')

#cards being altered
cards=('customizecards.dat' 'run_card.dat' 'proc_card.dat' 'extramodels.dat')


##Standard Model Name is ZDxxxxmodel_ZDtoxxdecay_MZDxxx_Mxxxxx_TuneCP5_madgraph-pythia8



declare -i j=0

home="~/genproductions/bin/MadGraph5_aMCatNLO"

#Start Process :D

for model in "${models[@]}"
do
    
    # ZDfD Model (1 set of masses, only ZD changes)
    if [ $j -eq 0 ]
    then
        #ZD masspoints
        masspoints=(80 91.1876 100 125 200 300 400 500 600 700)
        for mp in "${masspoints[@]}"
        do
            #Prevents FuckyWucky for next comparison
            int_mass=${mp%.*}

            #Creates Mass Specific Name
            if [ ${int_mass} -eq 91 ]
            then
                spec_model="${model}_${particles[1]}to${particles[2]}decay_M${particles[1]}91p1876_M${particles[2]}${std_particle_mass[2]}_M${particles[3]}${std_particle_mass[3]}_TuneCP5_madgraph-pythia8"
            else
                spec_model="${model}_${particles[1]}to${particles[2]}decay_M${particles[1]}${mp}_M${particles[2]}${std_particle_mass[2]}_M${particles[3]}${std_particle_mass[3]}_TuneCP5_madgraph-pythia8"
            fi

            #Create Mass Specific Directory
            dir="production/${spec_model}"
            mkdir -p "$dir"

            #Copy Cards from Model to Mass Specific Directory
            for card in "${cards[@]}"
            do
                cp "${model}/${model}_${card}" "${dir}/${spec_model}_${card}"
            done

            #Alter the Mass Specific Cards
            #customizecards
                sed -i "s/ZDMASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
                sed -i "s/FD1MASS/${std_particle_mass[2]}/g" "${dir}/${spec_model}_customizecards.dat"
                sed -i "s/FD2MASS/${std_particle_mass[3]}/g" "${dir}/${spec_model}_customizecards.dat"
            #run_card
                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
            #proc_card
                sed -i "s/DECAY/${decay[1]}/g" "${dir}/${spec_model}_proc_card.dat"
                sed -i "s/NAME/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
            #extramodels
                sed -i "s/DMMODEL/${DMmodels[1]}/g" "${dir}/${spec_model}_extramodels.dat"

            #Create Gridpack
            ./gridpack_generation.sh ${spec_model} ${dir}

            #Move Gridpack to ~/public
            mv ${spec_model}_slc7_amd64_gcc700_CMSSW_10_6_0_tarball.tar.xz ~/public/

            #Remove 'junk' and Clean
            rm -rf ${spec_model}/
            rm -rf ${spec_model}.log
        done


    # ZDsD Model (1 set of masses, only ZD changes)
    elif [ $j -eq 1 ]
    then
        masspoints=(60 91.1876 100 125 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400)
        for mp in "${masspoints[@]}"
        do
            #Prevents FuckyWucky
            int_mass=${mp%.*}

           #Creates Mass Specific Name
           if [ ${int_mass} -eq 91 ]
           then
                spec_model="${model}_${particles[1]}to${particles[4]}decay_M${particles[1]}91p1876_M${particles[4]}${std_particle_mass[4]}_TuneCP5_madgraph-pythia8"
            else
                spec_model="${model}_${particles[1]}to${particles[4]}decay_M${particles[1]}${mp}_M${particles[4]}${std_particle_mass[4]}_TuneCP5_madgraph-pythia8"
            fi

            #Create Mass Specific Directory
            dir="production/${spec_model}"
            mkdir -p "$dir"

            #Copy Cards from Model to Mass Specific Directory
            for card in "${cards[@]}"
            do
                cp "${model}/${model}_${card}" "${dir}/${spec_model}_${card}"
            done

            #Alter the Mass Specific Cards
                        #Alter the Mass Specific Cards
            #customizecards
                sed -i "s/ZDMASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
                sed -i "s/SDMASS/${std_particle_mass[4]}/g" "${dir}/${spec_model}_customizecards.dat"
            #run_card
                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
            #proc_card
                sed -i "s/DECAY/${decay[2]}/g" "${dir}/${spec_model}_proc_card.dat"
                sed -i "s/NAME/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
            #extramodels
                sed -i "s/DMMODEL/${DMmodels[2]}/g" "${dir}/${spec_model}_extramodels.dat"

            #Create Gridpack
            ./gridpack_generation.sh ${spec_model} ${dir}

            #Move Gridpack to ~/public
            mv ${spec_model}_slc7_amd64_gcc700_CMSSW_10_6_0_tarball.tar.xz ~/public/

            #Remove 'junk' and Clean
            rm -rf ${spec_model}/
            rm -rf ${spec_model}.log
        done


    # ZDfDsD Models (3 fD decay, 1 sD decay)
    elif [ $j -eq 2 ]
    then
        declare -i g=0
        
        for mode in "${decay[@]}"
        do
            declare -i k=0
            
            #fD decay
            if [ $g -eq 0 ]
            then
                for particle in "${particles[@]}"
                do
                    #ZD scan
                    if [ $k -eq 0 ]
                    then
                        masspoints=(80 91.1876 100 125 200 300 400 500 600 700)
                        for mp in "${masspoints[@]}"
                        do
                            #Prevents FuckyWucky
                            int_mass=${mp%.*}

                            #Creates Mass Specific Name
                            if [ ${int_mass} -eq 91 ]
                            then
                                spec_model="${model}_${particles[1]}to${particles[2]}decay_M${particles[1]}91p1876_M${particles[2]}${std_particle_mass[2]}_M${particles[3]}${std_particle_mass[3]}_TuneCP5_madgraph-pythia8"
                            else
                                spec_model="${model}_${particles[1]}to${particles[2]}decay_M${particles[1]}${mp}_M${particles[2]}${std_particle_mass[2]}_M${particles[3]}${std_particle_mass[3]}_TuneCP5_madgraph-pythia8"
                            fi

                            #Create Mass Specific Directory
                            dir="production/${spec_model}"
                            mkdir -p "$dir"

                            #Copy Cards from Model to Mass Specific Directory
                            for card in "${cards[@]}"
                            do
                                cp "${model}/${model}_${card}" "${dir}/${spec_model}_${card}"
                            done

                            #Alter the Mass Specific Cards
                            #customizecards
                                sed -i "s/ZDMASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/FD1MASS/${std_particle_mass[2]}/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/FD2MASS/${std_particle_mass[3]}/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/SDMASS/${std_particle_mass[4]}/g" "${dir}/${spec_model}_customizecards.dat"
                            #run_card
                                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
                            #proc_card
                                sed -i "s/DECAY/${decay[1]}/g" "${dir}/${spec_model}_proc_card.dat"
                                sed -i "s/NAME/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
                            #extramodels
                                sed -i "s/DMMODEL/${DMmodels[3]}/g" "${dir}/${spec_model}_extramodels.dat"

                            #Create Gridpack
                            ./gridpack_generation.sh ${spec_model} ${dir}

                            #Move Gridpack to ~/public
                            mv ${spec_model}_slc7_amd64_gcc700_CMSSW_10_6_0_tarball.tar.xz ~/public/

                            #Remove 'junk' and Clean
                            rm -rf ${spec_model}/
                            rm -rf ${spec_model}.log
                        done
                            
                    #fD1 scan
                    elif [ $k -eq 1 ]
                    then
                        masspoints=(5 50 100 150 200 225 235 245)
                        for mp in "${masspoints[@]}"
                        do
                            #Prevents FuckyWucky
                            int_mass=${mp%.*}

                            #Creates Mass Specific Name
                            spec_model="${model}_${particles[1]}to${particles[2]}decay_M${particles[1]}${std_particle_mass[1]}_M${particles[2]}${mp}_M${particles[3]}${std_particle_mass[3]}_TuneCP5_madgraph-pythia8"

                            #Create Mass Specific Directory
                            dir="production/${spec_model}"
                            mkdir -p "$dir"

                            #Copy Cards from Model to Mass Specific Directory
                            for card in "${cards[@]}"
                            do
                                cp "${model}/${model}_${card}" "${dir}/${spec_model}_${card}"
                            done

                            #Alter the Mass Specific Cards
                            #customizecards
                                sed -i "s/ZDMASS/${std_particle_mass[1]}/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/FD1MASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/FD2MASS/${std_particle_mass[3]}/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/SDMASS/${std_particle_mass[4]}/g" "${dir}/${spec_model}_customizecards.dat"
                            #run_card
                                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
                            #proc_card
                                sed -i "s/DECAY/${decay[1]}/g" "${dir}/${spec_model}_proc_card.dat"
                                sed -i "s/NAME/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
                            #extramodels
                                sed -i "s/DMMODEL/${DMmodels[3]}/g" "${dir}/${spec_model}_extramodels.dat"

                            #Create Gridpack
                            ./gridpack_generation.sh ${spec_model} ${dir}

                            #Move Gridpack to ~/public
                            mv ${spec_model}_slc7_amd64_gcc700_CMSSW_10_6_0_tarball.tar.xz ~/public/

                            #Remove 'junk' and Clean
                            rm -rf ${spec_model}/
                            rm -rf ${spec_model}.log
                        done
                    
                    #fD2 scan
                    elif [ $k -eq 2 ]
                    then
                        masspoints=(10 20 30 40 50)
                        for mp in "${masspoints[@]}"
                        do
                            #Prevents FuckyWucky
                            int_mass=${mp%.*}
                            
                            #Creates Mass Specific Name
                            spec_model="${model}_${particles[1]}to${particles[2]}decay_M${particles[1]}${std_particle_mass[1]}_M${particles[2]}${std_particle_mass[2]}_M${particles[3]}${mp}_TuneCP5_madgraph-pythia8"
                            
                            #Create Mass Specific Directory
                            dir="production/${spec_model}"
                            mkdir -p "$dir"
                            
                            #Copy Cards from Model to Mass Specific Directory
                            for card in "${cards[@]}"
                            do
                                cp "${model}/${model}_${card}" "${dir}/${spec_model}_${card}"
                            done
                            
                            #Alter the Mass Specific Cards
                            #customizecards
                                sed -i "s/ZDMASS/${std_particle_mass[1]}/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/FD1MASS/100/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/FD2MASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
                                sed -i "s/SDMASS/${std_particle_mass[4]}/g" "${dir}/${spec_model}_customizecards.dat"
                            #run_card
                                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
                            #proc_card
                                sed -i "s/DECAY/${decay[1]}/g" "${dir}/${spec_model}_proc_card.dat"
                                sed -i "s/NAME/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
                            #extramodels
                                sed -i "s/DMMODEL/${DMmodels[3]}/g" "${dir}/${spec_model}_extramodels.dat"
                            
                            #Create Gridpack
                            ./gridpack_generation.sh ${spec_model} ${dir}
                            
                            #Move Gridpack to ~/public
                            mv ${spec_model}_slc7_amd64_gcc700_CMSSW_10_6_0_tarball.tar.xz ~/public/
                            
                            #Remove 'junk' and Clean
                            rm -rf ${spec_model}/
                            rm -rf ${spec_model}.log
                        done
                    fi
                    k=$((k+1))
                done
            
            elif [ $g -eq 1 ]
            then
            #sD decay
                masspoints=(60 91.1876 100 125 200)
                for mp in "${masspoints[@]}"
                do
                    #Prevents FuckyWucky
                    int_mass=${mp%.*}

                    #Creates Mass Specific Name
                    if [ ${int_mass} -eq 91 ]
                    then
                        spec_model="${model}_${particles[1]}to${particles[4]}decay_M${particles[1]}91p1876_M${particles[4]}${std_particle_mass[4]}_TuneCP5_madgraph-pythia8"
                    else
                        spec_model="${model}_${particles[1]}to${particles[4]}decay_M${particles[1]}${mp}_M${particles[4]}${std_particle_mass[4]}_TuneCP5_madgraph-pythia8"
                    fi

                    #Create Mass Specific Directory
                    dir="production/${spec_model}"
                    mkdir -p "$dir"

                    #Copy Cards from Model to Mass Specific Directory
                    for card in "${cards[@]}"
                    do
                        cp "${model}/${model}_${card}" "${dir}/${spec_model}_${card}"
                    done

                    #Alter the Mass Specific Cards
                                #Alter the Mass Specific Cards
                    #customizecards
                        sed -i "s/ZDMASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
                        sed -i "s/FD1MASS/${std_particle_mass[2]}/g" "${dir}/${spec_model}_customizecards.dat"
                        sed -i "s/FD2MASS/${std_particle_mass[3]}/g" "${dir}/${spec_model}_customizecards.dat"
                        sed -i "s/SDMASS/${std_particle_mass[4]}/g" "${dir}/${spec_model}_customizecards.dat"
                    #run_card
                        sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
                    #proc_card
                        sed -i "s/DECAY/${decay[2]}/g" "${dir}/${spec_model}_proc_card.dat"
                        sed -i "s/NAME/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
                    #extramodels
                        sed -i "s/DMMODEL/${DMmodels[3]}/g" "${dir}/${spec_model}_extramodels.dat"

                    #Create Gridpack
                    ./gridpack_generation.sh ${spec_model} ${dir}

                    #Move Gridpack to ~/public
                    mv ${spec_model}_slc7_amd64_gcc700_CMSSW_10_6_0_tarball.tar.xz ~/public/

                    #Remove 'junk' and Clean
                    rm -rf ${spec_model}/
                    rm -rf ${spec_model}.log
                done
            fi
            
            g=$((g+1))
        done
    fi
    j=$((j+1))
done
