### 安装
```shell
 kubectl apply -f . -n bigdata-local
```
### 测试Iceberg和hive
```shell
bin/spark-sql --master yarn --jars iceberg-spark-runtime-3.1_2.12-0.13.2.jar,kyuubi-spark-connector-tpch_2.12-1.6.0-SNAPSHOT.jar \
--conf spark.hadoop.hive.metastore.uris=thrift://hive-metastore-service:9083 \
--conf spark.hadoop.hive.metastore.warehouse.dir=/app/hive/warehouse \
--conf spark.sql.catalog.spark_catalog=org.apache.iceberg.spark.SparkSessionCatalog \
--conf spark.sql.catalog.spark_catalog.type=hive  \
--conf spark.sql.catalog.tpch=org.apache.kyuubi.spark.connector.tpch.TPCHCatalog \
--num-executors 6 --executor-memory 2G
```
### 执行sql导入tpch数据到Iceberg表
```sql
-- lineitem
DROP TABLE IF EXISTS lineitem_iceberg;
Create  table db1.lineitem_iceberg USING iceberg as  select * from tpch.sf100.lineitem;


-- customer
DROP TABLE IF EXISTS customer_iceberg;
create table customer_iceberg  USING iceberg AS select * from tpch.sf100.customer;


-- nation
DROP TABLE IF EXISTS nation_iceberg;
create  table nation_iceberg  USING iceberg as select * from tpch.sf100.nation;

-- orders
DROP TABLE IF EXISTS orders_iceberg;
create  table orders_iceberg  USING iceberg as select * from tpch.sf100.orders;

-- part
DROP TABLE IF EXISTS part_iceberg;
create  table part_iceberg  USING iceberg as select * from tpch.sf100.part;

-- partsupp
DROP TABLE IF EXISTS partsupp_iceberg;
create  table partsupp_iceberg USING iceberg as select * from tpch.sf100.partsupp;

-- region
DROP TABLE IF EXISTS region_iceberg;
create  table region_iceberg USING iceberg as select * from tpch.sf100.region;

-- supplier
DROP TABLE IF EXISTS supplier_iceberg;
create  table supplier_iceberg  USING iceberg as select * from tpch.sf100.supplier;


-- q10
create table q10_returned_item_iceberg (c_custkey int, c_name string, revenue double, c_acctbal string, n_name string, c_address string, c_phone string, c_comment string) USING iceberg;
set spark.sql.adaptive.enabled=true;
set  spark.sql.adaptive.join.enabled=true ;
set  spark.sql.adaptive.skewedJoin.enabled=true;
insert overwrite table q10_returned_item_iceberg
select
    c_custkey, c_name, sum(l_extendedprice * (1 - l_discount)) as revenue,
    c_acctbal, n_name, c_address, c_phone, c_comment
from
    customer_iceberg c join orders_iceberg o
                                   on
                                           c.c_custkey = o.o_custkey and o.o_orderdate >= '1993-10-01' and o.o_orderdate < '1994-01-01'
                              join nation_iceberg n
                                   on
                                       c.c_nationkey = n.n_nationkey
                              join lineitem_iceberg l
                                   on
                                       l.l_orderkey = o.o_orderkey and l.l_returnflag = 'R'
group by c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment
order by revenue desc
    limit 20;




```

###导入数据到hive表
```sql
Create  table db1.lineitem_parquet USING parquet as  select * from db1.lineitem_iceberg;

```
