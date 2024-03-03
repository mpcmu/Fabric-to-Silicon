echo "Setting up Cadence environment..."
# Template for setting up cadence environment
export LM_LICENSE_FILE=$LM_LICENSE_FILE:??
export INNOV_DIR=??
export GENUS_DIR=??
export QRC_DIR=??
export LEC_DIR=??
export VOLTUS_TEMPUS_DIR=??
CDS_LIC_FILE=??
export PATH=${INNOV_DIR}/bin:${QRC_DIR}/bin:${GENUS_DIR}/bin:${VOLTUS_TEMPUS_DIR}/bin:${LEC_DIR}/bin:${PATH}

CALIBRE_HOME=/afs/ece.cmu.edu/support/mgc/mgc.release/cal_2022.2_aoi/aoi_cal_2022.2_38.20/;export CALIBRE_HOME
MGC_HOME=$CALIBRE_HOME

export PDK_PATH=??asap7/asap7_pdk_r1p7
export ASIC_PATH=??asap7sc7p5t_28
