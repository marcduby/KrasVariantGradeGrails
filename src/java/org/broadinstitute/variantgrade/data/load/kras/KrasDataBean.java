package org.broadinstitute.variantgrade.data.load.kras;

/**
 * Bean class to store the KRAS loaded data
 *
 * Created by mduby on 5/30/18.
 */
public class KrasDataBean {
    // instance variables
    private int position;
    private String refAllele;
    private String altAllele;
    private String NumberNucleotideSubstitution;
    private String mutation;
    private Double functionalMeanScore;
    private Double standardDeviationFunctionalScore;
    private int rank;
    private int cosmicCancerIncidence;
    private int genieCancerIncidence;
    private int tcgaCancerIncidence;
    private int exacGermlineIncidence;

    // constants
    public static final String REF = "Reference";
    public static final String ALT = "Alternate";
    public static final String POS = "Position";
    public static final String RANK = "Rank";
    public static final String NUM_NUCLEOTIDE = "NumberNucleotideSubstitution";
    public static final String MUTATION = "Mutation";
    public static final String FUNCTIONAL_SCORE = "FunctionalScore_Mean";
    public static final String STANDARD_DEVIATION = "StandardDeviationFunctionalScore";
    public static final String COSMIC = "CancerIncidence_COSMIC";
    public static final String GENIE = "CancerIncidence_GENIE";
    public static final String TCGA = "CancerIncidence_TCGA";
    public static final String EXAC = "GermlineIncidence_ExAC";

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public String getRefAllele() {
        return refAllele;
    }

    public void setRefAllele(String refAllele) {
        this.refAllele = refAllele;
    }

    public String getAltAllele() {
        return altAllele;
    }

    public void setAltAllele(String altAllele) {
        this.altAllele = altAllele;
    }

    public String getNumberNucleotideSubstitution() {
        return NumberNucleotideSubstitution;
    }

    public void setNumberNucleotideSubstitution(String numberNucleotideSubstitution) {
        NumberNucleotideSubstitution = numberNucleotideSubstitution;
    }

    public String getMutation() {
        return mutation;
    }

    public void setMutation(String mutation) {
        this.mutation = mutation;
    }

    public Double getFunctionalMeanScore() {
        return functionalMeanScore;
    }

    public void setFunctionalMeanScore(Double functionalMeanScore) {
        this.functionalMeanScore = functionalMeanScore;
    }

    public Double getStandardDeviationFunctionalScore() {
        return standardDeviationFunctionalScore;
    }

    public void setStandardDeviationFunctionalScore(Double standardDeviationFunctionalScore) {
        this.standardDeviationFunctionalScore = standardDeviationFunctionalScore;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public int getCosmicCancerIncidence() {
        return cosmicCancerIncidence;
    }

    public void setCosmicCancerIncidence(int cosmicCancerIncidence) {
        this.cosmicCancerIncidence = cosmicCancerIncidence;
    }

    public int getGenieCancerIncidence() {
        return genieCancerIncidence;
    }

    public void setGenieCancerIncidence(int genieCancerIncidence) {
        this.genieCancerIncidence = genieCancerIncidence;
    }

    public int getTcgaCancerIncidence() {
        return tcgaCancerIncidence;
    }

    public void setTcgaCancerIncidence(int tcgaCancerIncidence) {
        this.tcgaCancerIncidence = tcgaCancerIncidence;
    }

    public int getExacGermlineIncidence() {
        return exacGermlineIncidence;
    }

    public void setExacGermlineIncidence(int exacGermlineIncidence) {
        this.exacGermlineIncidence = exacGermlineIncidence;
    }
}
