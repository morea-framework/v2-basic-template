---
title: "Experience the Baz"
published: true
morea_id: experience3
morea_type: experience
morea_summary: "The third experiential learning event."
morea_sort_order: 3
---

### Experiential Learning 3

An experiential learning opportunity.  Here's some java code:

{% highlight java linenos %}


    package ics311;

    import java.util.Map.Entry;

    /**
     * This interface is to be used for all of the Dynamic Sets you create for this assignment.
     *
     * @author      Robert Ward
     * @version     1.0
     * @since       2014-02-01
     */
    public interface DynamicSet<Key extends Comparable<Key> , Value> {



       /**
        * Returns the name of Data Structure this set uses.
        *
        * @return  the name of Data Structure this set uses.
        */
        public String setDataStructure();

       /**
        * Returns the number of key-value mappings in this set.
        * This method returns zero if the set is empty
        *
        * @return  the number of key-value mappings in this set.
        */
        public int size();

        /**
        * Associates the specified value with the specified key in this map.
        * If the map previously contained a mapping for the key, the old value is replaced.
        * If there is no current mapping for this key return null,
        * otherwise the previous value associated with key.
        *
        * @param  key - key with which the specified value is to be associated
        * @param  value - value to be associated with the specified key
        *
        * @return the previous value associated with key, or null if there was no mapping for key.
        *  (A null return can also indicate that the map previously associated null with key.)
        */
        public Value insert(Key key, Value value);


        /**
        * Removes the mapping for this key from this set if present.
        *
        * @param key - key for which mapping should be removed
        *
        * @return the previous value associated with key, or null if there was no mapping for key.
        * (A null return can also indicate that the map previously associated null with key.)
        */
        public Value delete(Key key);


        /**
        * Returns the value to which the specified key is mapped, or null if this set contains no
            * mapping for the key.
        *
        * @param  key The key under which this data is stored.
        *
        * @return the Value of element stored in the set under the Key key.
        */
        public Value retrieve(Key key);


        /**
        * Returns a key-value mapping associated with the least key in this map, or null if the set
            * is empty.
        * IMPORTANT: This operation only applies when there is a total ordering on the Key
        * Returns null if the set is empty. If there is not total ordering on the Key returns null.
        *
        * @return an entry with the least key, or null if this map is empty
        */
        public Entry<Key, Value>  minimum( );


        /**
        * Returns a key-value mapping associated with the greatest key in this map, or null if the
            * map is empty.
        * IMPORTANT: This operation only applies when there is a total ordering on the Key
        * Returns null if the set is empty. If there is not total ordering on the key returns null.
        *
        * @return an entry with the greatest key, or null if this map is empty.
        */
        public Entry<Key, Value>  maximum( );


        /**
        * Returns a key-value mapping associated with the least key strictly greater than the given
            * key, or null if there is no such key.
        * IMPORTANT: This operation only applies when there is a total ordering on the key
        * Returns null if the set is empty or the key is not found.
        * Returns null if the key is the maximum element.
        * If there is not total ordering on the key for the set returns null.
        * @param key - the key
        *
        * @return an entry with the greatest key less than key, or null if there is no such key
        */
        public Entry<Key, Value>  successor(Key key);

        /**
        * Returns a key-value mapping associated with the greatest key strictly less than the given
            * key, or null if there is no such key.
        * IMPORTANT: This operation only applies when there is a total ordering on the key
        * Returns null if the set is empty or the key is not found.
        * Returns null if the key is the minimum element.
        * If there is not total ordering on the key for the set returns null.
        * @param key - the key
        *
        * @return an entry with the greatest key less than key, or null if there is no such key
        */
        public Entry<Key, Value>  predecessor(Key key);


    }

{% endhighlight %}
