#!/bin/bash
#~ND~FORMAT~MARKDOWN~
#~ND~START~
#
# 
#~ND~END~

# Setup this script such that if any command exits with a non-zero value, the 
# script itself exits and does not attempt any further processing.
set -e

# Global default values
DEFAULT_B0_MAX_BVAL=50

#
# Function Descripton
# Show usage information for this script
#
usage()
{
	local scriptName=$(basename ${0})
	echo ""
	echo " Preprocessing Pipeline for ANTs JLF"
	echo ""
	echo "  Usage: ${scriptName} <options>"
	echo ""
	echo "  Options: [ ] = optional; < > = user supplied value"
	echo ""
	echo "    [--help] : show usage information and exit with non-zero return code"
	echo ""
	echo "    [--version] : show version information and exit with 0 as return code"
	echo ""
	echo "    --path=<study-path>"
	echo "    : path to subject's data folder"
	echo ""
	echo "    --subject=<subject-id>"
	echo "    : Subject ID"
	echo ""
	echo "    --PEdir=<phase-encoding-dir>"
	echo "    : phase encoding direction: 1=LR/RL, 2=AP/PA"
	echo ""
	echo "    --posData=<positive-phase-encoding-data>"
	echo "    : @ symbol separated list of data with positive phase encoding direction"
	echo "      e.g. dataRL1@dataRL2@...dataRLN"
	echo ""
	echo "    --negData=<negative-phase-encoding-data>"
	echo "    : @ symbol separated list of data with negative phase encoding direction"
	echo "      e.g. dataLR1@dataLR2@...dataLRN"
	echo ""
	echo "    --echospacing=<echo-spacing>"
	echo "    : Echo spacing in msecs"
	echo ""
	echo "    --gdcoeffs=<path-to-gradients-coefficients-file>"
	echo "    : path to file containing coefficients that describe spatial variations"
	echo "      of the scanner gradients. Use --gdcoeffs=NONE if not available"
	echo ""
	echo "    [--dwiname=<DWIName>]"
	echo "    : name to give DWI output directories"
	echo "      defaults to Diffusion"
	echo ""
	echo "    [--dof=<Degrees of Freedom>]"
	echo "    : Degrees of Freedom for post eddy registration to structural images"
	echo "      defaults to 6"
	echo ""
	echo "    [--b0maxbval=<b0-max-bval>]"
	echo "    : Volumes with a bvalue smaller than this value will be considered as b0s"
	echo "      If not specified, defaults to ${DEFAULT_B0_MAX_BVAL}"
	echo ""
	echo "    [--printcom=<print-command>]"
	echo "    : Use the specified <print-command> to echo or otherwise output the commands"
	echo "      that would be executed instead of actually running them"
	echo "      --printcom=echo is intended for testing purposes"
	echo ""
	echo "  Return Code:"
	echo ""
	echo "    0 if help was not requested, all parameters were properly formed, and processing succeeded"
	echo "    Non-zero otherwise - malformed parameters, help requested, or processing failure was detected"
	echo ""
	echo "  Required Environment Variables:"
	echo ""
	echo "    HCPPIPEDIR"
	echo ""
	echo "      The home directory for the version of the HCP Pipeline Tools product"
	echo "      being used."
	echo ""
	echo "      Example value: /nrgpackages/tools.release/hcp-pipeline-tools-3.0"
	echo ""
	echo "    HCPPIPEDIR_dMRI"
	echo ""
	echo "      Location of Diffusion MRI sub-scripts that are used to carry out some of the"
	echo "      steps of the Diffusion Preprocessing Pipeline"
	echo ""
	echo "      Example value: ${HCPPIPEDIR}/DiffusionPreprocessing/scripts"
	echo ""
	echo "    FSLDIR"
	echo ""
	echo "      The home directory for FSL"
	echo ""
	echo "    FREESURFER_HOME"
	echo ""
	echo "      Home directory for FreeSurfer"
	echo ""
	echo "    PATH"
	echo ""
	echo "      Must be set to find HCP Customized version of gradient_unwarp.py"
	echo ""
}

#
# Function Description
#  Get the command line options for this script
#
# Global Output Variables
#  ${StudyFolder}		- Path to subject's data folder
#  ${Subject}			- Subject ID
#  ${PEdir}				- Phase Encoding Direction, 1=LR/RL, 2=AP/PA
#  ${PosInputImages}	- @ symbol separated list of data with positive phase encoding direction
#  ${NegInputImages}	- @ symbol separated lsit of data with negative phase encoding direction
#  ${echospacing}		- echo spacing in msecs
#  ${GdCoeffs}			- Path to file containing coefficients that describe spatial variations
#						  of the scanner gradients. Use NONE if not available.
#  ${DWIName}			- Name to give DWI output directories
#  ${DegreesOfFreedom}	- Degrees of Freedom for post eddy registration to structural images
#  ${b0maxbval}			- Volumes with a bvalue smaller than this value will be considered as b0s
#  ${runcmd}			- Set to a user specifed command to use if user has requested that commands
#						  be echo'd (or printed) instead of actually executed.  Otherwise, set to
#						  empty string.
#
get_options()
{
	local scriptName=$(basename ${0})
	local arguments=($@)
	
	# initialize global output variables
	unset StudyFolder
	unset Subject
	unset PEdir
	unset PosInputImages
	unset NegInputImages
	unset echospacing
	unset GdCoeffs
	DWIName="Diffusion"
	DegreesOfFreedom=6
	b0maxbval=${DEFAULT_B0_MAX_BVAL}
	runcmd=""
	
	# parse arguments
	local index=0
	local numArgs=${#arguments[@]}
	local argument
	
	while [ ${index} -lt ${numArgs} ]
	do
		argument=${arguments[index]}
		
		case ${argument} in
			--help)
				usage
				exit 1
				;;
			--version)
				version_show $@
				exit 0
				;;
			--path=*)
				StudyFolder=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--subject=*)
				Subject=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--PEdir=*)
				PEdir=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--posData=*)
				PosInputImages=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--negData=*)
				NegInputImages=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--echospacing=*)
				echospacing=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--gdcoeffs=*)
				GdCoeffs=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--dwiname=*)
				DWIName=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--dof=*)
				DegreesOfFreedom=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--b0maxbval=*)
				b0maxbval=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			--printcom=*)
				runcmd=${argument/*=/""}
				index=$(( index + 1 ))
				;;
			*)
				usage
				echo "ERROR: Unrecognized Option: ${argument}"
				exit 1
				;;
		esac
	done
	
	# check required parameters
	if [ -z ${StudyFolder} ]
	then
		usage
		echo "ERROR: <study-path> not specified"
		exit 1
	fi
	
	if [ -z ${Subject} ]
	then
		usage
		echo "ERROR: <subject-id> not specified"
		exit 1
	fi
	
	# report options
	echo "-- ${scriptName}: Specified Command-Line Options - Start --"
	echo "   StudyFolder: ${StudyFolder}"
	echo "   Subject: ${Subject}"
	echo "   PEdir: ${PEdir}"
	echo "   PosInputImages: ${PosInputImages}"
	echo "   NegInputImages: ${NegInputImages}"
	echo "   echospacing: ${echospacing}"
	echo "   GdCoeffs: ${GdCoeffs}"
	echo "   DWIName: ${DWIName}"
	echo "   DegreesOfFreedom: ${DegreesOfFreedom}"
	echo "   b0maxbval: ${b0maxbval}"
	echo "   runcmd: ${runcmd}"
	echo "-- ${scriptName}: Specified Command-Line Options - End --"
}

# 
# Function Description
#  Validate necessary environment variables
#
validate_environment_vars()
{
	local scriptName=$(basename ${0}) 
	# validate
	if [ -z ${HCPPIPEDIR_dMRI} ]
	then
		usage
		echo "ERROR: HCPPIPEDIR_dMRI environment variable not set"
		exit 1
	fi
	
	if [ ! -e ${HCPPIPEDIR}/DiffusionPreprocessing/DiffPreprocPipeline_PreEddy.sh ]
	then
		usage
		echo "ERROR: HCPPIPEDIR/DiffusionPreprocessing/DiffPreprocPipeline_PreEddy.sh not found"
		exit 1
	fi
	
	if [ ! -e ${HCPPIPEDIR}/DiffusionPreprocessing/DiffPreprocPipeline_Eddy.sh ]
	then
		usage
		echo "ERROR: HCPPIPEDIR/DiffusionPreprocessing/DiffPreprocPipeline_Eddy.sh not found"
		exit 1
	fi
	
	if [ ! -e ${HCPPIPEDIR}/DiffusionPreprocessing/DiffPreprocPipeline_PostEddy.sh ]
	then
		usage
		echo "ERROR: HCPPIPEDIR/DiffusionPreprocessing/DiffPreprocPipeline_PostEddy.sh not found"
		exit 1
	fi
	
	if [ -z ${FSLDIR} ]
	then
		usage
		echo "ERROR: FSLDIR environment variable not set"
		exit 1
	fi
	
	# report
	echo "-- ${scriptName}: Environment Variables Used - Start --"
	echo "   HCPPIPEDIR_dMRI: ${HCPPIPEDIR_dMRI}"
	echo "   FSLDIR: ${FSLDIR}"
	echo "-- ${scriptName}: Environment Variables Used - End --"
}

#
# Function Description
#  Main processing of script
#
main()
{
	# Get Command Line Options
	# 
	# Global Variables Set
	#  See documentation for get_options function
	get_options $@
	
	# Validate environment variables
	validate_environment_vars $@
	
	# Establish tool name for logging
	log_SetToolName "DiffPreprocPipeline.sh"
	
	log_Msg "Invoking Pre-Eddy Steps"
	${HCPPIPEDIR}/DiffusionPreprocessing/DiffPreprocPipeline_PreEddy.sh \
		--path=${StudyFolder} \
		--subject=${Subject} \
		--dwiname=${DWIName} \
		--PEdir=${PEdir} \
		--posData=${PosInputImages} \
		--negData=${NegInputImages} \
		--echospacing=${echospacing} \
		--b0maxbval=${b0maxbval} \
		--printcom="${runcmd}"
	
	log_Msg "Invoking Eddy Step"
	${HCPPIPEDIR}/DiffusionPreprocessing/DiffPreprocPipeline_Eddy.sh \
		--path=${StudyFolder} \
		--subject=${Subject} \
		--dwiname=${DWIName} \
		--printcom="${runcmd}"
	
	log_Msg "Invoking Post-Eddy Steps"
	${HCPPIPEDIR}/DiffusionPreprocessing/DiffPreprocPipeline_PostEddy.sh \
		--path=${StudyFolder} \
		--subject=${Subject} \
		--dwiname=${DWIName} \
		--gdcoeffs=${GdCoeffs} \
		--dof=${DegreesOfFreedom} \
		--printcom="${runcmd}"
	
	log_Msg "Completed"
	exit 0
}

#
# Invoke the main function to get things started
#
main $@

