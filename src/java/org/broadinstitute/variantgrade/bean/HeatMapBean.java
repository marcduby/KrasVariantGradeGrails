package org.broadinstitute.variantgrade.bean;

import org.broadinstitute.variantgrade.util.GradeException;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * Class to hold the heat maps
 *
 * Created by mduby on 10/11/17.
 */
public class HeatMapBean {
    // instance variables
    private Map<Integer, PositionMatrixBean> positionMatrixMap = new HashMap<Integer, PositionMatrixBean>();              // map of position to heat map
    private String name;
    private InputStream heatMapStream;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Map<Integer, PositionMatrixBean> getHeatMap() {
        return positionMatrixMap;
    }

    public Map<Integer, PositionMatrixBean> getPositionMatrixMap() {
        return positionMatrixMap;
    }

    /**
     * get the position mtrix at the position given
     *
     * @param position
     * @param referenceAllele
     * @param throwsErrorIfRefAlleleDiffernent
     * @return
     * @throws GradeException
     */
    public PositionMatrixBean getPositionMatrixBean(Integer position, String referenceAllele, boolean throwsErrorIfRefAlleleDiffernent) throws GradeException {
        PositionMatrixBean positionMatrixBean = this.positionMatrixMap.get(position);

        // if null create and set reference
        if (positionMatrixBean == null) {
            positionMatrixBean = new PositionMatrixBean(position, referenceAllele);
            this.positionMatrixMap.put(position, positionMatrixBean);

        } else {
            if (throwsErrorIfRefAlleleDiffernent) {
                if (referenceAllele == null) {
                    throw new GradeException("provided null reference allele for lookup");

                } else if (!referenceAllele.equalsIgnoreCase(positionMatrixBean.getReferenceLetter())) {
                    throw new GradeException("provided reference allele: '" + referenceAllele + "' is different from the matrix allele: '" + positionMatrixBean.getReferenceLetter() +"'");
                }
            }
        }

        // return
        return positionMatrixBean;
    }

    public void setPositionMatrixMap(Map<Integer, PositionMatrixBean> positionMatrixMap) {
        this.positionMatrixMap = positionMatrixMap;
    }

    public InputStream getHeatMapStream() {
        return heatMapStream;
    }

    public void setHeatMapStream(InputStream heatMapStream) {
        this.heatMapStream = heatMapStream;
    }
}
