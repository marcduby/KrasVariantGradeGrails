package org.broadinstitute.variantgrade.data.load.kras;

/**
 * Created by mduby on 6/3/18.
 */
public class KrasPLotBean {
    // instance variables
    private Integer rank;
    private Double coslog;
    private String numnuc;
    private Double score;

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public Double getCoslog() {
        return coslog;
    }

    public void setCoslog(Double coslog) {
        this.coslog = coslog;
    }

    public String getNumnuc() {
        return numnuc;
    }

    public void setNumnuc(String numnuc) {
        this.numnuc = numnuc;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }
}
