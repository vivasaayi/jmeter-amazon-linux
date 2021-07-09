jmeter -n -e -t ${TESTS_ROOT}/simple-test.jmx \
    -l ${JMETER_OUTPUT_PATH}/results.jtl \
    -j ${JMETER_OUTPUT_PATH}/jmeter-log.txt \
    -o ${JMETER_OUTPUT_PATH}/reports

ls ${JMETER_OUTPUT_PATH}
ls ${JMETER_OUTPUT_PATH}/reports
cat ${JMETER_OUTPUT_PATH}/results.jtl 
cat ${JMETER_OUTPUT_PATH}/jmeter-log.txt