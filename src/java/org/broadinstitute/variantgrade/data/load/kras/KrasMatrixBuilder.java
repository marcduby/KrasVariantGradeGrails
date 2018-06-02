package org.broadinstitute.variantgrade.data.load.kras;

import org.apache.log4j.Logger;
import org.broadinstitute.variantgrade.bean.HeatMapBean;
import org.broadinstitute.variantgrade.bean.PositionMatrixBean;
import org.broadinstitute.variantgrade.util.GradeException;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Builder class to build the set of heat maps from the KRAS data file reader
 *
 * Created by mduby on 6/2/18.
 */
public class KrasMatrixBuilder {
    // instance variables
    Logger loaderLogger = Logger.getLogger(this.getClass().getName());


    /**
     * builds a map of meat map keyed by type of map
     *
     * @param filePath
     * @return
     * @throws GradeException
     */
    public Map<String, HeatMapBean> loadHeatMaps(String filePath) throws GradeException {
        // instance variables
        Map<String, HeatMapBean> heatMapBeanByTypeMap = null;     // map of types of string to heat maps with data in them
        List<KrasDataBean> krasDataBeanList = null;
        KrasFlatFileLoader krasFlatFileLoader = null;

        // get the file loader
        krasFlatFileLoader = new KrasFlatFileLoader(filePath);

        // load the file into the bean
        krasDataBeanList = krasFlatFileLoader.load();
        this.loaderLogger.info("Got list of kras objects of size: " + krasDataBeanList.size());

        // get the heat maps map
        heatMapBeanByTypeMap = this.loadHeatMapFromBeanList(krasDataBeanList);

        // log
        this.loaderLogger.info("Have a map of heat maps of number of types: " + heatMapBeanByTypeMap.keySet().size());

        // return the heat maps
        return heatMapBeanByTypeMap;
    }

    private PositionMatrixBean getPositionMastrix(Map<String, HeatMapBean> heatMapBeanByTypeMap, String heatMapType, int position, String referenceAllele, boolean errorIfExistingRefDoesNotMatch) throws GradeException {
        // local variables
        HeatMapBean heatMapBean = heatMapBeanByTypeMap.get(heatMapType);

        // load the map for the functional score
        if ( heatMapBean == null) {
            heatMapBean = new HeatMapBean();
            heatMapBean.setName(heatMapType);
            heatMapBeanByTypeMap.put(heatMapType, heatMapBean);
        }

        // get the position matrix for the position
        PositionMatrixBean positionMatrixBean = heatMapBean.getPositionMatrixBean(position, referenceAllele, errorIfExistingRefDoesNotMatch);

        // return
        return positionMatrixBean;
    }

    /**
     * load the heam maps map from the file input stream
     *
     * @param fileStream
     * @return
     * @throws GradeException
     */
    public Map<String, HeatMapBean> loadHeatMaps(InputStream fileStream) throws GradeException {
        // instance variables
        Map<String, HeatMapBean> heatMapBeanByTypeMap = null;     // map of types of string to heat maps with data in them
        List<KrasDataBean> krasDataBeanList = null;
        KrasFlatFileLoader krasFlatFileLoader = null;

        // get the file loader
        krasFlatFileLoader = new KrasFlatFileLoader(fileStream);

        // load the file into the bean
        krasDataBeanList = krasFlatFileLoader.load();
        this.loaderLogger.info("Got list of kras objects of size: " + krasDataBeanList.size());

        // get the heat maps map
        heatMapBeanByTypeMap = this.loadHeatMapFromBeanList(krasDataBeanList);

        // return
        return heatMapBeanByTypeMap;
    }

    /**
     * load the heat maps map from the given list of data row beans
     *
     * @param krasDataBeanList
     * @return
     * @throws GradeException
     */
    private Map<String, HeatMapBean> loadHeatMapFromBeanList(List<KrasDataBean> krasDataBeanList) throws GradeException {
        // instance variables
        Map<String, HeatMapBean> heatMapBeanByTypeMap = new HashMap<String, HeatMapBean>();     // map of types of string to heat maps with data in them

        // got each row, populate the appropriate heat map
        for (KrasDataBean krasDataBean : krasDataBeanList) {
//            HeatMapBean heatMapBean = heatMapBeanByTypeMap.get(KrasDataBean.FUNCTIONAL_SCORE);
//
//            // load the map for the functional score
//            if ( heatMapBean == null) {
//                heatMapBean = new HeatMapBean();
//                heatMapBean.setName(KrasDataBean.FUNCTIONAL_SCORE);
//                heatMapBeanByTypeMap.put(KrasDataBean.FUNCTIONAL_SCORE, heatMapBean);
//            }

            // get the functional score position matrix for the position
            PositionMatrixBean positionMatrixBean = this.getPositionMastrix(heatMapBeanByTypeMap, KrasDataBean.FUNCTIONAL_SCORE, krasDataBean.getPosition(), krasDataBean.getRefAllele(), true);
                    // heatMapBean.getPositionMatrixBean(krasDataBean.getPosition(), krasDataBean.getRefAllele(), true);

            // add an entry for the alt allele
            if (positionMatrixBean.getDoubleHeatEntry(krasDataBean.getAltAllele()) != null) {
                throw new GradeException("Already have double entry at alt allele: " + krasDataBean.getAltAllele());

            } else {
                positionMatrixBean.addDoubleHeatEntry(krasDataBean.getAltAllele(), krasDataBean.getFunctionalMeanScore());
            }

            // get the functional score position matrix for the position
            positionMatrixBean = this.getPositionMastrix(heatMapBeanByTypeMap, KrasDataBean.STANDARD_DEVIATION, krasDataBean.getPosition(), krasDataBean.getRefAllele(), true);
            // heatMapBean.getPositionMatrixBean(krasDataBean.getPosition(), krasDataBean.getRefAllele(), true);

            // add an entry for the alt allele
            if (positionMatrixBean.getDoubleHeatEntry(krasDataBean.getAltAllele()) != null) {
                throw new GradeException("Already have double entry at alt allele: " + krasDataBean.getAltAllele());

            } else {
                positionMatrixBean.addDoubleHeatEntry(krasDataBean.getAltAllele(), krasDataBean.getStandardDeviationFunctionalScore());
            }

            // get the mutation position matrix for the position
            positionMatrixBean = this.getPositionMastrix(heatMapBeanByTypeMap, KrasDataBean.MUTATION, krasDataBean.getPosition(), krasDataBean.getRefAllele(), true);
            // heatMapBean.getPositionMatrixBean(krasDataBean.getPosition(), krasDataBean.getRefAllele(), true);

            // add an entry for the alt allele
            if (positionMatrixBean.getStringHeatEntry(krasDataBean.getAltAllele()) != null) {
                throw new GradeException("Already have string entry at alt allele: " + krasDataBean.getAltAllele());

            } else {
                positionMatrixBean.addStringHeatEntry(krasDataBean.getAltAllele(), krasDataBean.getMutation());
            }
        }

        // return
        return heatMapBeanByTypeMap;
    }

}
