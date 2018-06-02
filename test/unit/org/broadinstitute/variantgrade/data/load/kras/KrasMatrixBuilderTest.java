package org.broadinstitute.variantgrade.data.load.kras;

import junit.framework.TestCase;
import org.apache.log4j.Logger;
import org.broadinstitute.variantgrade.bean.HeatMapBean;
import org.broadinstitute.variantgrade.util.GradeException;

import java.util.Map;

/**
 * Class to test the KRAS matrix builder
 *
 * Created by mduby on 5/30/18.
 */
public class KrasMatrixBuilderTest extends TestCase {
    // instance variables
    private String filePath = "/Users/mduby/Google Drive/Broad/Documents/Work/Broad/Projects/20180507krasGrade/MutantKRASv2Modified.csv";
    Logger testLogger = Logger.getLogger(this.getClass().getName());

    public void testLoadHeatMaps() {
        // instance variables
        Map<String, HeatMapBean> heatMapBeanMap = null;
        KrasMatrixBuilder krasMatrixBuilder = new KrasMatrixBuilder();

        try {
            // get the list of data
            heatMapBeanMap = krasMatrixBuilder.loadHeatMaps(this.filePath);

        } catch (GradeException exception) {
            fail("Got exception: " + exception.getMessage());
        }

        // test
        assertNotNull(heatMapBeanMap);
        assertTrue(heatMapBeanMap.size() > 0);
        assertEquals(8, heatMapBeanMap.size());
        System.out.println("Got " + heatMapBeanMap.size() + " maps loaded");

        // loop through the list and check all data
        for (HeatMapBean heatMapBean : heatMapBeanMap.values()) {
            assertNotNull(heatMapBean);
            assertNotNull(heatMapBean.getName());
            assertNotNull(heatMapBean.getPositionMatrixMap());
            assertTrue(heatMapBean.getPositionMatrixMap().size() > 0);
            assertEquals(187, heatMapBean.getPositionMatrixMap().size());
        }

        // check the functional data map
        HeatMapBean heatMapBean = heatMapBeanMap.get(KrasDataBean.FUNCTIONAL_SCORE);
        assertNotNull(heatMapBean);
        assertNotNull(heatMapBean.getName());
        assertNotNull(heatMapBean.getPositionMatrixMap());
        assertTrue(heatMapBean.getPositionMatrixMap().size() > 0);
        assertEquals(187, heatMapBean.getPositionMatrixMap().size());

        // check the functional data map
        heatMapBean = heatMapBeanMap.get(KrasDataBean.MUTATION);
        assertNotNull(heatMapBean);
        assertNotNull(heatMapBean.getName());
        assertNotNull(heatMapBean.getPositionMatrixMap());
        assertTrue(heatMapBean.getPositionMatrixMap().size() > 0);
        assertEquals(187, heatMapBean.getPositionMatrixMap().size());

        // check the functional data map
        heatMapBean = heatMapBeanMap.get(KrasDataBean.STANDARD_DEVIATION);
        assertNotNull(heatMapBean);
        assertNotNull(heatMapBean.getName());
        assertNotNull(heatMapBean.getPositionMatrixMap());
        assertTrue(heatMapBean.getPositionMatrixMap().size() > 0);
        assertEquals(187, heatMapBean.getPositionMatrixMap().size());
    }


}
