#!/bin/bash
# This script will take your subjects from raw DICOMs through ANTs or JLF

# Setup this script such that if any command exits with a non-zero value, the
# script itself exits and does not attempt any further processing.
set -e

# Global default values

#
# Function Descripton
# Show usage information for this script
#
usage()
{
	local scriptName=$(basename ${0})
  echo ""
  echo " Preprocessing Pipeline for ANTs"

}

#
# Function Description
#  Get the command line options for this script
#
get_options()
{

}

#
# Function Description
#  Validate necessary environment variables
#
validate_environment_vars()
{

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
  log_SetToolName "biabl_master_script.sh"

  log_Msg "Converting DICOMS to Nifti"
  log_Msg "ACPC Aligning the Subject"
  log_Msg "Skull Stripping the Brain"
  log_Msg "Running JLF"
  log_Msg "Running ANTs"
  log_Msg "Completed"
  exit 0
}

#
# Invoke the main function to get things started
#
main $@
