package org.broadinstitute.variantgrade.data.load.kras;

import org.broadinstitute.variantgrade.util.GradeException;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Class to load the data from a CSV file in the format where each line is a position/alt combination (assuming the ref is consistent within the positions)
 *
 * Created by mduby on 5/30/18.
 */
public class KrasFlatFileLoader {
    // instance variables
    private String filePath;
    private InputStream fileInputStream;
    private Map<String, Integer> headerLineMap = new HashMap<String, Integer>();
    List<KrasDataBean> krasDataBeanList = new ArrayList<KrasDataBean>();

    public KrasFlatFileLoader(String value) {
        this.filePath = value;
    }

    public KrasFlatFileLoader(InputStream inputStream) {
        this.fileInputStream = inputStream;
    }

    /**
     * load the data file into internal data structure
     *
     * @throws GradeException
     */
    public List<KrasDataBean> load() throws GradeException {
        // local variables
        BufferedReader reader = null;
        String[] headerLine = null;
        String[] tempLine = null;
        int count = 0;
        Integer position = null;
        String referenceLetter = null;
        String tempString = null;

        // load and parse the file
        String line = "";
        String cvsSplitBy = ",";

        // load the file
        try {
            reader = new BufferedReader(new InputStreamReader(this.getFileInputStream()));

            while ((line = reader.readLine()) != null) {
                // first line is header line
                if (count == 0) {
                    headerLine = line.split(cvsSplitBy);

                    // load the index map
                    this.populateHeaderMatrix(headerLine);

                } else {
                    tempLine = line.split(cvsSplitBy);

                    // create the bean
                    KrasDataBean krasDataBean = new KrasDataBean();

                    // add in the data
                    // position
                    try {
                        tempString = tempLine[this.headerLineMap.get(KrasDataBean.POS)];
                        krasDataBean.setPosition(Integer.valueOf(tempString));

                    } catch (NumberFormatException exception) {
                        throw new GradeException("Got position integer format error: " + tempString + ": " + exception.getMessage());
                    }

                    // cosmic number
                    try {
                        tempString = tempLine[this.headerLineMap.get(KrasDataBean.COSMIC)];
                        krasDataBean.setCosmicCancerIncidence(Integer.valueOf(tempString));

                    } catch (NumberFormatException exception) {
                        throw new GradeException("Got cosmic integer format error: " + tempString + ": " + exception.getMessage());
                    }

                    // genie number
                    try {
                        tempString = tempLine[this.headerLineMap.get(KrasDataBean.GENIE)];
                        krasDataBean.setGenieCancerIncidence(Integer.valueOf(tempString));

                    } catch (NumberFormatException exception) {
                        throw new GradeException("Got genie integer format error: " + tempString + ": " + exception.getMessage());
                    }

                    // tgca number
                    try {
                        tempString = tempLine[this.headerLineMap.get(KrasDataBean.TCGA)];
                        krasDataBean.setTcgaCancerIncidence(Integer.valueOf(tempString));

                    } catch (NumberFormatException exception) {
                        throw new GradeException("Got tcga integer format error: " + tempString + ": " + exception.getMessage());
                    }

                    // exac number
                    try {
                        tempString = tempLine[this.headerLineMap.get(KrasDataBean.EXAC)];
                        krasDataBean.setExacGermlineIncidence(Integer.valueOf(tempString));

                    } catch (NumberFormatException exception) {
                        throw new GradeException("Got exac integer format error: " + tempString + ": " + exception.getMessage());
                    }

                    // rank
                    try {
                        tempString = tempLine[this.headerLineMap.get(KrasDataBean.RANK)];
                        krasDataBean.setRank(Integer.valueOf(tempString));

                    } catch (NumberFormatException exception) {
                        throw new GradeException("Got rank integer format error: " + tempString + ": " + exception.getMessage());
                    }

                    // nucleotide number
                    tempString = tempLine[this.headerLineMap.get(KrasDataBean.NUM_NUCLEOTIDE)];
                    krasDataBean.setNumberNucleotideSubstitution(tempString);

                    // ref
                    tempString = tempLine[this.headerLineMap.get(KrasDataBean.REF)];
                    krasDataBean.setRefAllele(tempString);

                    // alt
                    tempString = tempLine[this.headerLineMap.get(KrasDataBean.ALT)];
                    krasDataBean.setAltAllele(tempString);

                    // mutation
                    tempString = tempLine[this.headerLineMap.get(KrasDataBean.MUTATION)];
                    krasDataBean.setMutation(tempString);

                    // functional score
                    try {
                        tempString = tempLine[this.headerLineMap.get(KrasDataBean.FUNCTIONAL_SCORE)];
                        krasDataBean.setFunctionalMeanScore(Double.valueOf(tempString));

                    } catch (NumberFormatException exception) {
                        throw new GradeException("Got functional score double format error: " + tempString + ": " + exception.getMessage());
                    }

                    // standard deviation
                    try {
                        tempString = tempLine[this.headerLineMap.get(KrasDataBean.STANDARD_DEVIATION)];
                        krasDataBean.setStandardDeviationFunctionalScore(Double.valueOf(tempString));

                    } catch (NumberFormatException exception) {
                        throw new GradeException("Got functional score std double format error: " + tempString + ": " + exception.getMessage());
                    }

                    // add the bean to the list
                    this.krasDataBeanList.add(krasDataBean);

//                    // no go through line array and create position heat object
//                    // index 1 is position number
//                    try {
//                        position = Integer.parseInt(tempLine[1]);
//
//                    } catch (NumberFormatException exception) {
//                        throw new GradeException("Got bad position at line: " + count + " :" + tempLine + " : )" + exception.getMessage());
//                    }
//
//                    // index 2 is reference letter
//                    // cmiter change (no quotes)
////                    referenceLetter = tempLine[0].substring(1, 2);
//                    referenceLetter = tempLine[0];
//
//                    // check data issues
//                    if (position == null) {
//                        throw new GradeException("Got null position at line: " + count + " : " + tempLine);
//                    }
//
//                    if (referenceLetter == null) {
//                        throw new GradeException("Got null reference letter at line: " + count + " : " + tempLine);
//                    }
//
//                    // loop through rest of array and create heat object
//                    positionMatrixBean = new PositionMatrixBean(position, referenceLetter);
//                    for (int i = 2; i < headerLine.length; i++) {
//                        // cmiter change (no quotes)
////                        positionMatrixBean.addHeatEntry(headerLine[i].substring(1, 2), new Double(tempLine[i]));
//                        if (headerLine[i] == null) {
//                            throw new GradeException("Got error in header line for type: " + matrixType + " and position: " + i);
//
//                        } else if ((tempLine[i] == null) || (tempLine[i].trim().length() < 1)) {
//                            positionMatrixBean.addHeatEntry(headerLine[i], new Double(0));
//
//                        } else {
//                            try {
//                                positionMatrixBean.addHeatEntry(headerLine[i], new Double(tempLine[i]));
//
//                            } catch (NumberFormatException exception) {
//                                positionMatrixBean.addHeatEntry(headerLine[i], null);
//                            }
//                        }
//                    }
//
//                    // if all went well, add to map
//                    mapToPopulate.put(position, positionMatrixBean);
                }

                // add to count
                count++;
            }
        } catch (FileNotFoundException exception) {
            throw new GradeException("Got file exception reading heat map file: " + exception.getMessage());

        } catch (IOException exception) {
            throw new GradeException("Got data file load exception: " + exception.getMessage());
        }

        // return
        return krasDataBeanList;
    }

    /**
     * IO loading of the data
     *
     * @return
     * @throws GradeException
     */
    private InputStream getFileInputStream() throws GradeException {
        if (this.fileInputStream != null) {
            return this.fileInputStream;

        } else {
            if (this.filePath != null) {
                try {
                    File initialFile = new File(this.filePath);
                    InputStream targetStream = new FileInputStream(initialFile);

                    return targetStream;

                } catch (IOException exception) {
                    throw new GradeException("Got file reading exception: " + exception.getMessage());
                }

            } else {
                throw new GradeException("Null file and input stream, so no loading");
            }
        }
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    /**
     * populate the header position lookup map
     *
     * @param values
     */
    private void populateHeaderMatrix(String[] values) {
        for (int i = 0; i < values.length; i++) {
            this.headerLineMap.put(values[i], i);
        }
    }
}
