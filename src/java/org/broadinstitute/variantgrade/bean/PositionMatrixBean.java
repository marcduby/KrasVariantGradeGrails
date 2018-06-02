package org.broadinstitute.variantgrade.bean;

import org.broadinstitute.variantgrade.util.GradeException;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by mduby on 12/22/15.
 */
public class PositionMatrixBean {
    // instance variables
    private int position;
    private String referenceLetter;                                                             // reference allele
    private Map<String, Double> heatMapDouble = new HashMap<String, Double>();                  // map of alt allele letter to double value
    private Map<String, String> heatMapString = new HashMap<String, String>();                  // map of alt allele letter to string value

    /**
     * default constructor
     *
     * @param position
     * @param reference
     */
    public PositionMatrixBean(int position, String reference) {
        this.position = position;
        this.referenceLetter = reference;
    }

    /**
     * add new heat entry
     *
     * @param referenceLetter
     * @param heatAmount
     * @throws GradeException
     */
    public void addHeatEntry(String referenceLetter, Double heatAmount) throws GradeException {
        // make sure no entry there yet
        if (this.heatMapDouble.get(referenceLetter) != null) {
            throw new GradeException("Got duplicate entry at letter: " + referenceLetter);
        }

        // if not, enter new entry
        this.heatMapDouble.put(referenceLetter, heatAmount);
    }

    /**
     * return the heat number
     *
     * @param referenceLetter
     * @return
     * @throws GradeException
     */
    public Double getHeatNumber(String referenceLetter) throws GradeException {
        return this.heatMapDouble.get(referenceLetter);
    }

    /**
     * add new heat entry
     *
     * @param referenceLetter
     * @param heatAmount
     * @throws GradeException
     */
    public void addDoubleHeatEntry(String referenceLetter, Double heatAmount) throws GradeException {
        // make sure no entry there yet
        if (this.heatMapDouble.get(referenceLetter) != null) {
            throw new GradeException("Got duplicate double entry at letter: " + referenceLetter);
        }

        // if not, enter new entry
        this.heatMapDouble.put(referenceLetter, heatAmount);
    }

    /**
     * return the heat number
     *
     * @param referenceLetter
     * @return
     * @throws GradeException
     */
    public Double getDoubleHeatEntry(String referenceLetter) throws GradeException {
        return this.heatMapDouble.get(referenceLetter);
    }

    /**
     * add new heat entry
     *
     * @param referenceLetter
     * @param heatAmount
     * @throws GradeException
     */
    public void addStringHeatEntry(String referenceLetter, String heatAmount) throws GradeException {
        // make sure no entry there yet
        if (this.heatMapString.get(referenceLetter) != null) {
            throw new GradeException("Got duplicate string entry at letter: " + referenceLetter);
        }

        // if not, enter new entry
        this.heatMapString.put(referenceLetter, heatAmount);
    }

    /**
     * return the heat number
     *
     * @param referenceLetter
     * @return
     * @throws GradeException
     */
    public String getStringHeatEntry(String referenceLetter) throws GradeException {
        return this.heatMapString.get(referenceLetter);
    }

    public String getReferenceLetter() {
        return referenceLetter;
    }
}
