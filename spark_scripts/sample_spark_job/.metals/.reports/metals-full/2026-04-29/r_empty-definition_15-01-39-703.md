error id: file:///C:/Users/ugoet/ugo-dev/sample_spark_job/src/main/scala/edu/vcu/sample_spark_job/WordCount.scala:
file:///C:/Users/ugoet/ugo-dev/sample_spark_job/src/main/scala/edu/vcu/sample_spark_job/WordCount.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -org/apache/spark/rdd/Int#
	 -Int#
	 -scala/Predef.Int#
offset: 702
uri: file:///C:/Users/ugoet/ugo-dev/sample_spark_job/src/main/scala/edu/vcu/sample_spark_job/WordCount.scala
text:
```scala
package edu.vcu.sample_spark_job

/**
 * Everyone's favourite wordcount example.
 */

import org.apache.spark.rdd._

object WordCount {
  /**
   * A slightly more complex than normal wordcount example with optional
   * separators and stopWords. Splits on the provided separators, removes
   * the stopwords, and converts everything to lower case.
   */

  // use the REPL to understand what individual expressions are doing
  // e.g. what is separators: Array[Char] = " ".toCharArray doing?
  // scala> separators: Array[Char] 
  def withStopWordsFiltered(rdd : RDD[String],
    separators : Array[Char] = " ".toCharArray,
    stopWords : Set[String] = Set("the")): RDD[(String, In@@t)] = {

    val tokens: RDD[String] = rdd.flatMap(_.split(separators).
      map(_.trim.toLowerCase))
    val lcStopWords = stopWords.map(_.trim.toLowerCase)
    val words = tokens.filter(token =>
      !lcStopWords.contains(token) && (token.length > 0)) // this is an anonymous function. RDD.filter() expects an anonymous function that returns a boolean: true if we want to retain the element and false if we do not
    val wordPairs = words.map((_, 1)) // take close note that the output of the map is a collection of sequences ~ (key, value)
    val wordCounts = wordPairs.reduceByKey(_ + _) // here the key is implicitly taken to be the first element in each sequence of the collection and is not referenced further
    wordCounts
  }
}

```


#### Short summary: 

empty definition using pc, found symbol in pc: 