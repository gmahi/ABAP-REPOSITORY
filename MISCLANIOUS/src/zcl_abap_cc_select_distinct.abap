CLASS zcl_abap_cc_select_distinct DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_cc_select_distinct IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(sentence) = 'ABAP is excellent'.
    SPLIT condense( sentence ) AT | | INTO TABLE DATA(words).
    out->write( | Number of words: { lines( words ) }|  ).
    IF cl_abap_dbfeatures=>use_features(
         requested_features =  VALUE #( (  cl_abap_dbfeatures=>itabs_in_from_clause ) )  ).
      LOOP AT words ASSIGNING FIELD-SYMBOL(<word>).
        DATA(characters) = VALUE abap_sortorder_tab(  FOR char = 0 THEN char + 1 UNTIL char = strlen( <word> ) ( name = <word>+char(1) ) ).
        SELECT DISTINCT * FROM @characters AS charcters INTO TABLE @DATA(unique_characters).
        out->write( |Number of unique characters in the word: { <word> } - { lines( unique_characters ) }| ).
      ENDLOOP.
    ELSE.
      out->write(  | Bummer: Not supoorted SELECT FROM @ITAB on this system| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.