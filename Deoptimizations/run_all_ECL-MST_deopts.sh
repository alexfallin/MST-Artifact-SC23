#!/bin/bash
echo 'Deoptimized runs'

echo 'Running all files...'

for FILE in inputs/*.egr
do
	./ecl_mst $FILE >> ecl_mst_out.csv
	./ecl_mst_NAG $FILE >> ecl_mst_NAG_out.csv
	./ecl_mst_NAG_NW $FILE >> ecl_mst_NAG_NW_out.csv
	./ecl_mst_NAG_NW_NF $FILE >> ecl_mst_NAG_NW_NF_out.csv
	./ecl_mst_NAG_NW_NF_NIPC $FILE >> ecl_mst_NAG_NW_NF_NIPC_out.csv
	./ecl_mst_NAG_NW_NF_NIPC_NOD $FILE >> ecl_mst_NAG_NW_NF_NIPC_NOD_out.csv
	./ecl_mst_NAG_NW_NF_NIPC_NOD_NT $FILE >> ecl_mst_NAG_NW_NF_NIPC_NOD_NT_out.csv
	./ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD $FILE >> ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD_out.csv
	./ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD_NEB $FILE >> ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD_NEB_out.csv
done

echo 'copying results to root directory'

cp ecl_mst_out.csv ..
cp ecl_mst_NAG_out.csv ..
cp ecl_mst_NAG_NW_out.csv ..
cp ecl_mst_NAG_NW_NF_out.csv ..
cp ecl_mst_NAG_NW_NF_NIPC_out.csv ..
cp ecl_mst_NAG_NW_NF_NIPC_NOD_out.csv ..
cp ecl_mst_NAG_NW_NF_NIPC_NOD_NT_out.csv ..
cp ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD_out.csv ..
cp ecl_mst_NAG_NW_NF_NIPC_NOD_NT_NDD_NEB_out.csv ..