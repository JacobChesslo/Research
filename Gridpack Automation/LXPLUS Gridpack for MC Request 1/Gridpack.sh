#!/bin/sh

#  Gridpack.sh
#  Created by Jacob Chesslo on 11/12/20.
#
# For Use in lxplus6.cern.ch , with genproductions copied from cms github
# Place all files

        # temp_dir = ${template_dir[$j]}
        
#inside of MadGraph5_aMCatNLO of genproductions/bin/

#model folders are in /production

models=('ZDfD' 'ZDfDsD_fD1scan_fDdecay' 'ZDfDsD_fD2scan_fDdecay' 'ZDfDsD_sDdecay' 'ZDfDsD_ZDscan_fDdecay' 'ZDsD')
cards=('customizecards.dat' 'run_card.dat' 'proc_card.dat' 'extramodels.dat')
#template_dir=('ZDfD_ZDM80toM700' 'ZDfDsD_fD1M5toM245_fDdecay' 'ZDfDsD_fD2M2toM50_fDdecay' 'ZDfDsD_ZDM60toM200_sDdecay' 'ZDfDsD_ZDM80toM700_fDdecay' 'ZDsD_ZDM60toM1400')

declare -i j=0

home="~/genproductions/bin/MadGraph5_aMCatNLO"

#Start Process :D

for model in "${models[@]}"
do
    
    #ZDfD
    if [ $j -eq 0 ]
    then
        masspoints=(80 91.1876 100 125 200 300 400 500 600 700)
        for mp in "${masspoints[@]}"
        do
            #Prevents FuckyWucky
            int_mass=${mp%.*}
            
            #Creates Mass Specific Name
            if [ ${int_mass} -eq 91 ]
            then
                spec_model="${model}_M91p1876"
            else
                spec_model="${model}_M${mp}"
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
                sed -i "s/MASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
            #run_card
                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
            #proc_card
                sed -i "s/MASS/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
            #extramodels
                #Nothing Changed
            
            #Create Gridpack
            ./gridpack_generation.sh ${spec_model} ${dir}
            
            #Move Gridpack to ~/public
            mv ${spec_model}_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz ~/public/
            
            #Remove 'junk' and Clean
            rm -rf ${spec_model}/
            rm -rf ${spec_model}.log
        done
        
    #ZDfDsD_fD1
    elif [ $j -eq 1 ]
    then
        masspoints=(5 50 100 150 200 225 235 245)
        for mp in "${masspoints[@]}"
        do
            #Prevents FuckyWucky
            int_mass=${mp%.*}
            
            #Creates Mass Specific Name
            if [ ${int_mass} -eq 91 ]
            then
                spec_model="${model}_M91p1876"
            else
                spec_model="${model}_M${mp}"
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
                sed -i "s/MASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
            #run_card
                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
            #proc_card
                sed -i "s/MASS/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
            #extramodels
                #Nothing Changed
            
            #Create Gridpack
            ./gridpack_generation.sh ${spec_model} ${dir}
            
            #Move Gridpack to ~/public
            mv ${spec_model}_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz ~/public/
            
            #Remove 'junk' and Clean
            rm -rf ${spec_model}/
            rm -rf ${spec_model}.log
        done
        
    #ZDfDsD_fD2
    elif [ $j -eq 2 ]
    then
        masspoints=(10 20 30 40 50)
        for mp in "${masspoints[@]}"
        do
            #Prevents FuckyWucky
            int_mass=${mp%.*}
            
            #Creates Mass Specific Name
            if [ ${int_mass} -eq 91 ]
            then
                spec_model="${model}_M91p1876"
            else
                spec_model="${model}_M${mp}"
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
                sed -i "s/MASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
            #run_card
                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
            #proc_card
                sed -i "s/MASS/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
            #extramodels
                #Nothing Changed
            
            #Create Gridpack
            ./gridpack_generation.sh ${spec_model} ${dir}
            
            #Move Gridpack to ~/public
            mv ${spec_model}_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz ~/public/
            
            #Remove 'junk' and Clean
            rm -rf ${spec_model}/
            rm -rf ${spec_model}.log
        done
        
    #ZDfDsD_sD
    elif [ $j -eq 3 ]
    then
        masspoints=(60 91.1876 100 125 200)
        for mp in "${masspoints[@]}"
        do
            #Prevents FuckyWucky
            int_mass=${mp%.*}
            
            #Creates Mass Specific Name
            if [ ${int_mass} -eq 91 ]
            then
                spec_model="${model}_M91p1876"
            else
                spec_model="${model}_M${mp}"
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
                sed -i "s/MASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
            #run_card
                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
            #proc_card
                sed -i "s/MASS/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
            #extramodels
                #Nothing Changed
            
            #Create Gridpack
            ./gridpack_generation.sh ${spec_model} ${dir}
            
            #Move Gridpack to ~/public
            mv ${spec_model}_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz ~/public/
            
            #Remove 'junk' and Clean
            rm -rf ${spec_model}/
            rm -rf ${spec_model}.log
        done
        
    #ZDfDsD_ZD_fD
    elif [ $j -eq 4 ]
    then
        masspoints=(80 91.1876 100 125 200 300 400 500 600 700)
        for mp in "${masspoints[@]}"
        do
            #Prevents FuckyWucky
            int_mass=${mp%.*}
            
            #Creates Mass Specific Name
            if [ ${int_mass} -eq 91 ]
            then
                spec_model="${model}_M91p1876"
            else
                spec_model="${model}_M${mp}"
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
                sed -i "s/MASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
            #run_card
                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
            #proc_card
                sed -i "s/MASS/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
            #extramodels
                #Nothing Changed
            
            #Create Gridpack
            ./gridpack_generation.sh ${spec_model} ${dir}
            
            #Move Gridpack to ~/public
            mv ${spec_model}_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz ~/public/
            
            #Remove 'junk' and Clean
            rm -rf ${spec_model}/
            rm -rf ${spec_model}.log
        done
        
    #ZDsD
    else
        masspoints=(60 91.1876 100 125 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400)
        for mp in "${masspoints[@]}"
        do
            #Prevents FuckyWucky
            int_mass=${mp%.*}
            
            #Creates Mass Specific Name
            if [ ${int_mass} -eq 91 ]
            then
                spec_model="${model}_M91p1876"
            else
                spec_model="${model}_M${mp}"
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
                sed -i "s/MASS/${mp}/g" "${dir}/${spec_model}_customizecards.dat"
            #run_card
                sed -i "s/EVENTS/5000/g" "${dir}/${spec_model}_run_card.dat"
            #proc_card
                sed -i "s/MASS/${spec_model}/g" "${dir}/${spec_model}_proc_card.dat"
            #extramodels
                #Nothing Changed
            
            #Create Gridpack
            ./gridpack_generation.sh ${spec_model} ${dir}
            
            #Move Gridpack to ~/public
            mv ${spec_model}_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz ~/public/
            
            #Remove 'junk' and Clean
            rm -rf ${spec_model}/
            rm -rf ${spec_model}.log
        done
    fi
    j=$((j+1))
done
