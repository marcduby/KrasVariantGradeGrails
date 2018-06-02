package org.broadinstitute.variantgrade.data.load.kras;

import junit.framework.TestCase;
import org.apache.log4j.Logger;
import org.broadinstitute.variantgrade.util.GradeException;

import java.util.List;

/**
 * Class to test the KRAS data file loading
 *
 * Created by mduby on 5/30/18.
 */
public class KrasFlatFileLoaderTest extends TestCase {
    // instance variables
    private String filePath = "/Users/mduby/Google Drive/Broad/Documents/Work/Broad/Projects/20180507krasGrade/MutantKRASv2Modified.csv";
    Logger testLogger = Logger.getLogger(this.getClass().getName());

    public void testLoad() {
        // instance variables
        List<KrasDataBean> krasDataList = null;

        try {
            // load the file
            KrasFlatFileLoader flatFileLoader = new KrasFlatFileLoader(this.filePath);

            // get the list of data
            krasDataList = flatFileLoader.load();

        } catch (GradeException exception) {
            fail("Got exception: " + exception.getMessage());
        }

        // test
        assertNotNull(krasDataList);
        assertTrue(krasDataList.size() > 0);
        assertEquals(3716, krasDataList.size());
        System.out.println("Got " + krasDataList.size() + " rows loaded");

        // loop through the list and check all data
        for (KrasDataBean krasDataBean : krasDataList) {
            assertNotNull(krasDataBean);
            assertTrue(krasDataBean.getPosition() > 0);
            assertNotNull(krasDataBean.getRefAllele());
            assertNotNull(krasDataBean.getAltAllele());
            assertTrue(krasDataBean.getFunctionalMeanScore() < 1000);
            assertTrue(krasDataBean.getStandardDeviationFunctionalScore() < 1000);
            assertTrue(krasDataBean.getCosmicCancerIncidence() >= 0);
            assertTrue(krasDataBean.getGenieCancerIncidence() >= 0);
            assertTrue(krasDataBean.getTcgaCancerIncidence() >= 0);
            assertTrue(krasDataBean.getExacGermlineIncidence() >= 0);
            assertNotNull(krasDataBean.getMutation());
            assertTrue(krasDataBean.getRank() > 0);
            assertNotNull(krasDataBean.getNumberNucleotideSubstitution());
        }
    }


}
