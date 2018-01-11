--@author Daniel Jordan
--@version 1.0
--@date 2/17/17
pragma Ada_2012;

with Ada.Text_IO; use ada.Text_IO;
with Ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.unchecked_conversion;

procedure floatflip is

   --Declaration of my Modular type.
   type Unsigned is mod 2**32; --Integer is declared a new type
   package Unsigned_IO is new Ada.Text_IO.Modular_IO (Num => Unsigned);
   use Unsigned_IO;

   subtype Bit is Integer range 0 .. 1;

   type BitString is array(1 .. 32) of Bit
     with Component_Size => 1, size => 32;

   function convertBitStringToFloat is new ada.Unchecked_Conversion(Source => BitString, target => Float);

   function convertFloatToBitString is new ada.unchecked_conversion(source => float, target => BitString);

   function convertUnsignedToFloat is new ada.Unchecked_Conversion(source => Unsigned, target => Float);

   function calculateExponent(anArray : BitString) return Integer is

      calculatedExponent: Integer := 0;
      countExponent: Integer := 7;

   begin

      for e in reverse 1 .. 8 loop

         if(anArray(e) = 1) then
            calculatedExponent := calculatedExponent + 2**countExponent;
         end if;

         countExponent := countExponent - 1;

         exit when countExponent = -1;

      end loop;

      return (calculatedExponent - 127);

   end calculateExponent;

   procedure print_Row3_Col3 (final_row_array1: in out BitString) is

       my_finalArray: BitString;

   begin

      my_finalArray := final_row_array1;

      --Prints the sign bit for row 1, col 3
      for i in reverse 32 .. 32 loop
         put(my_finalArray(i), width => 1);
      end loop;

      put(":");--Beginning of the exponent section for row 1, col 3

      --Prints the first 4 Bits of the exponent for row 1, col 3
      for j in reverse 28 .. 31 loop
         put(my_finalArray(j), width => 1);
      end loop;

      put(" ");--Spacing for the exponent section for row 1, col 3

      --Prints the last 4 Bits of the exponent for row 1, col 3
      for k in reverse 24 .. 27 loop
         put(my_finalArray(k), width => 1);
      end loop;

      put(":");--End of the exponent section for row 1, col 3

      --Prints the first set of 4 Bits of the mantissa for row 1, col 3
      for ii in reverse 20 .. 23 loop
         put(my_finalArray(ii), width => 1);
      end loop;

      put(" ");--First space for the mantissa row 1, col 3

      --Prints the second set of  4 Bits of the mantissa for row 1, col 3
      for jj in reverse 16 .. 19 loop
         put(my_finalArray(jj), width => 1);
      end loop;

      put(" ");--Second space for the mantissa row 1, col 3

      --Prints the third set of 4 Bits of the mantissa for row 1, col 3
      for kk in reverse 12 .. 15 loop
         put(my_finalArray(kk), width => 1);
      end loop;

      put(" ");--Third space for the mantissa row 1, col 3

      --Prints the fourth set of 4 Bits of the mantissa for row 1, col 3
      for iii in reverse 8 .. 11 loop
         put(my_finalArray(iii), width => 1);
      end loop;

      put(" ");--Fourth space for the mantissa row 1, col 3

      --Prints the fifth set of 4 Bits of the mantissa for row 1, col 3
      for jjj in reverse 4 .. 7 loop
         put(my_finalArray(jjj), width => 1);
      end loop;

      put(" ");--Fifth space for the mantissa row 1, col 3

      --Prints the last set of 3 Bits of the mantissa for row 1, col 3
      for kkk in reverse 1 .. 3 loop
         put(my_finalArray(kkk), width => 1);
      end loop;

      New_Line;

   end print_Row3_Col3;

    procedure print_Row3_Col2 (final_row_array: in out BitString) is

     final_signArray: BitString; --used to store the sign bit slice from array2
      final_exponentArray: BitString; --used to store the exponent slice from array2
      final_mantissaArray: BitString; --used to store the mantissa slice from array2
      final_oneCount: Integer := 0;
      final_zeroCount: Integer := 0;
      final_exponent: Integer := 0;

   begin

      final_signArray(1 .. 1) := final_row_array(32 .. 32);
      final_exponentArray(1 .. 8) := final_row_array(24 .. 31);
      final_mantissaArray(1 .. 23) := final_row_array(1 .. 23);

      --For loop to determine the sign for col 2
      for i in 1 .. 1 loop
         --This if else puts the sign of col 2
         if (final_signArray(i) = 1) then

            put("-");

         else

            put("+");

         end if;

      end loop;

      --For loop to determine the "hidden Bit"
      for j in 1 .. 8 loop

         --This if else determines the hidden Bit for col 2
         if(final_exponentArray(j) = 1) then

            final_oneCount := final_oneCount + 1;

         else

            final_zeroCount := final_zeroCount + 1;

         end if;

      end loop;

      --This if, elsif determines the "hidden" Bit based on the count of
      --the zeros and the ones in the exponentArray
      if(final_oneCount >= 1) then

         put("1.");

      elsif(final_zeroCount > 7) then

         put("0.");

      end if;

      --For loop to put the first set of 4 Bits of the mantissa for col 2
      for ii in reverse 20 .. 23 loop
         --for ii in 1 .. 4 loop

         put(final_mantissaArray(ii), width => 1);

      end loop;

      put(" ");

      --For loop to put the second set of 4 Bits of the mantissa for col 2
      for jj in reverse 16 .. 19 loop
         --for jj in 5 .. 8 loop

         put(final_mantissaArray(jj), width => 1);

      end loop;

      put(" ");

      --For loop to put the third set of 4 Bits of the mantissa for col 2
      for hh in reverse 12 .. 15 loop
         --for hh in 9 .. 12 loop

         put(final_mantissaArray(hh), width => 1);

      end loop;

      put(" ");

      --For loop to put the fourth set of 4 Bits of the mantissa for col 2
      for kk in reverse 8 .. 11 loop
         --for kk in 13 .. 16 loop

         put(final_mantissaArray(kk), width => 1);

      end loop;

      put(" ");

      --For loop to put the first 4 Bits of  the mantissa for col 2
      for mm in reverse 4 .. 7 loop
         --for mm in 17 .. 20 loop

         put(final_mantissaArray(mm), width => 1);

      end loop;

      put(" ");

      --For loop to put the first 4 Bits of  the mantissa for col 2
      for nn in reverse 1 .. 3 loop
         --for nn in 21 .. 23 loop

         put(final_mantissaArray(nn), width => 1);

      end loop;

      put("E");

      final_exponent := calculateExponent(final_exponentArray);

      put(final_exponent, width => 3);

      put("   ");

      print_Row3_Col3(final_row_array);

   end print_Row3_Col2;

   procedure print_Row2_Col3 (inversedArray1: in out BitString) is

      myArray: BitString;

   begin

      myArray := inversedArray1;

      --Prints the sign bit for row 1, col 3
      for i in reverse 32 .. 32 loop
         put(myArray(i), width => 1);
      end loop;

      put(":");--Beginning of the exponent section for row 1, col 3

      --Prints the first 4 Bits of the exponent for row 1, col 3
      for j in reverse 28 .. 31 loop
         put(myArray(j), width => 1);
      end loop;

      put(" ");--Spacing for the exponent section for row 1, col 3

      --Prints the last 4 Bits of the exponent for row 1, col 3
      for k in reverse 24 .. 27 loop
         put(myArray(k), width => 1);
      end loop;

      put(":");--End of the exponent section for row 1, col 3

      --Prints the first set of 4 Bits of the mantissa for row 1, col 3
      for ii in reverse 20 .. 23 loop
         put(myArray(ii), width => 1);
      end loop;

      put(" ");--First space for the mantissa row 1, col 3

      --Prints the second set of  4 Bits of the mantissa for row 1, col 3
      for jj in reverse 16 .. 19 loop
         put(myArray(jj), width => 1);
      end loop;

      put(" ");--Second space for the mantissa row 1, col 3

      --Prints the third set of 4 Bits of the mantissa for row 1, col 3
      for kk in reverse 12 .. 15 loop
         put(myArray(kk), width => 1);
      end loop;

      put(" ");--Third space for the mantissa row 1, col 3

      --Prints the fourth set of 4 Bits of the mantissa for row 1, col 3
      for iii in reverse 8 .. 11 loop
         put(myArray(iii), width => 1);
      end loop;

      put(" ");--Fourth space for the mantissa row 1, col 3

      --Prints the fifth set of 4 Bits of the mantissa for row 1, col 3
      for jjj in reverse 4 .. 7 loop
         put(myArray(jjj), width => 1);
      end loop;

      put(" ");--Fifth space for the mantissa row 1, col 3

      --Prints the last set of 3 Bits of the mantissa for row 1, col 3
      for kkk in reverse 1 .. 3 loop
         put(myArray(kkk), width => 1);
      end loop;

      New_Line;

   end print_Row2_Col3;

   procedure print_Row1_Col3 (array1: in out BitString) is

      myArray: BitString;

   begin

      myArray := array1;

      --Prints the sign bit for row 1, col 3
      for i in reverse 32 .. 32 loop
         put(myArray(i), width => 1);
      end loop;

      put(":");--Beginning of the exponent section for row 1, col 3

      --Prints the first 4 Bits of the exponent for row 1, col 3
      for j in reverse 28 .. 31 loop
         put(myArray(j), width => 1);
      end loop;

      put(" ");--Spacing for the exponent section for row 1, col 3

      --Prints the last 4 Bits of the exponent for row 1, col 3
      for k in reverse 24 .. 27 loop
         put(myArray(k), width => 1);
      end loop;

      put(":");--End of the exponent section for row 1, col 3

      --Prints the first set of 4 Bits of the mantissa for row 1, col 3
      for ii in reverse 20 .. 23 loop
         put(myArray(ii), width => 1);
      end loop;

      put(" ");--First space for the mantissa row 1, col 3

      --Prints the second set of  4 Bits of the mantissa for row 1, col 3
      for jj in reverse 16 .. 19 loop
         put(myArray(jj), width => 1);
      end loop;

      put(" ");--Second space for the mantissa row 1, col 3

      --Prints the third set of 4 Bits of the mantissa for row 1, col 3
      for kk in reverse 12 .. 15 loop
         put(myArray(kk), width => 1);
      end loop;

      put(" ");--Third space for the mantissa row 1, col 3

      --Prints the fourth set of 4 Bits of the mantissa for row 1, col 3
      for iii in reverse 8 .. 11 loop
         put(myArray(iii), width => 1);
      end loop;

      put(" ");--Fourth space for the mantissa row 1, col 3

      --Prints the fifth set of 4 Bits of the mantissa for row 1, col 3
      for jjj in reverse 4 .. 7 loop
         put(myArray(jjj), width => 1);
      end loop;

      put(" ");--Fifth space for the mantissa row 1, col 3

      --Prints the last set of 3 Bits of the mantissa for row 1, col 3
      for kkk in reverse 1 .. 3 loop
         put(myArray(kkk), width => 1);
      end loop;

      New_Line;

   end print_Row1_Col3;

   procedure print_Row2_Col2 (inverseArray: in out BitString) is

      inversed_signArray: BitString; --used to store the sign bit slice from array2
      inversed_exponentArray: BitString; --used to store the exponent slice from array2
      inversed_mantissaArray: BitString; --used to store the mantissa slice from array2
      inversed_oneCount: Integer := 0;
      inversed_zeroCount: Integer := 0;
      inversed_exponent: Integer := 0;

   begin

      inversed_signArray(1 .. 1) := inverseArray(32 .. 32);
      inversed_exponentArray(1 .. 8) := inverseArray(24 .. 31);
      inversed_mantissaArray(1 .. 23) := inverseArray(1 .. 23);

      --For loop to determine the sign for col 2
      for i in 1 .. 1 loop
         --This if else puts the sign of col 2
         if (inversed_signArray(i) = 1) then

            put("-");

         else

            put("+");

         end if;

      end loop;

      --For loop to determine the "hidden Bit"
      --for j in reverse 24 .. 31 loop
      for j in 1 .. 8 loop

         --This if else determines the hidden Bit for col 2
         if(inversed_exponentArray(j) = 1) then

            inversed_oneCount := inversed_oneCount + 1;

         else

            inversed_zeroCount := inversed_zeroCount + 1;

         end if;

      end loop;

      --This if, elsif determines the "hidden" Bit based on the count of
      --the zeros and the ones in the exponentArray
      if(inversed_oneCount >= 1) then

         put("1.");

      elsif(inversed_zeroCount > 7) then

         put("0.");

      end if;

      --For loop to put the first set of 4 Bits of the mantissa for col 2
      for ii in reverse 20 .. 23 loop
         --for ii in 1 .. 4 loop

         put(inversed_mantissaArray(ii), width => 1);

      end loop;

      put(" ");

      --For loop to put the second set of 4 Bits of the mantissa for col 2
      for jj in reverse 16 .. 19 loop
         --for jj in 5 .. 8 loop

         put(inversed_mantissaArray(jj), width => 1);

      end loop;

      put(" ");

      --For loop to put the third set of 4 Bits of the mantissa for col 2
      for hh in reverse 12 .. 15 loop
         --for hh in 9 .. 12 loop

         put(inversed_mantissaArray(hh), width => 1);

      end loop;

      put(" ");

      --For loop to put the fourth set of 4 Bits of the mantissa for col 2
      for kk in reverse 8 .. 11 loop
         --for kk in 13 .. 16 loop

         put(inversed_mantissaArray(kk), width => 1);

      end loop;

      put(" ");

      --For loop to put the first 4 Bits of  the mantissa for col 2
      for mm in reverse 4 .. 7 loop
         --for mm in 17 .. 20 loop

         put(inversed_mantissaArray(mm), width => 1);

      end loop;

      put(" ");

      --For loop to put the first 4 Bits of  the mantissa for col 2
      for nn in reverse 1 .. 3 loop
         --for nn in 21 .. 23 loop

         put(inversed_mantissaArray(nn), width => 1);

      end loop;

      put("E");

      inversed_exponent := calculateExponent(inversed_exponentArray);

      if(inversed_exponent = -127)then

         inversed_exponent := -126;

      end if;

      put(inversed_exponent, width => 3);

      put("  ");

      print_Row2_Col3(inverseArray);

   end print_Row2_Col2;

   procedure print_Row1_Col2 (array2: in BitString) is

      signArray: BitString; --used to store the sign bit slice from array2
      exponentArray: BitString; --used to store the exponent slice from array2
      mantissaArray: BitString; --used to store the mantissa slice from array2
      oneCount: Integer := 0;
      zeroCount: Integer := 0;
      exponent: Integer := 0;

   begin

      signArray(1 .. 1) := array2(32 .. 32);
      exponentArray(1 .. 8) := array2(24 .. 31);
      mantissaArray(1 .. 23) := array2(1 .. 23);

      --For loop to determine the sign for col 2
      --for i in reverse 32 .. 32 loop
      for i in 1 .. 1 loop
         --This if else puts the sign of col 2
         if (signArray(i) = 1) then

            put("-");

         else

            put("+");

         end if;

      end loop;

      --For loop to determine the "hidden Bit"
      --for j in reverse 24 .. 31 loop
      for j in 1 .. 8 loop

         --This if else determines the hidden Bit for col 2
         if(exponentArray(j) = 1) then

            oneCount := oneCount + 1;

         else

            zeroCount := zeroCount + 1;

         end if;

      end loop;

      --This if, elsif determines the "hidden" Bit based on the count of
      --the zeros and the ones in the exponentArray
      if(oneCount >= 1) then

         put("1.");

      elsif(zeroCount > 7) then

         put("0.");

      end if;

      --For loop to put the first set of 4 Bits of the mantissa for col 2
      for ii in reverse 20 .. 23 loop
         --for ii in 1 .. 4 loop

         put(mantissaArray(ii), width => 1);

      end loop;

      put(" ");

      --For loop to put the second set of 4 Bits of the mantissa for col 2
      for jj in reverse 16 .. 19 loop
         --for jj in 5 .. 8 loop

         put(mantissaArray(jj), width => 1);

      end loop;

      put(" ");

      --For loop to put the third set of 4 Bits of the mantissa for col 2
      for hh in reverse 12 .. 15 loop
         --for hh in 9 .. 12 loop

         put(mantissaArray(hh), width => 1);

      end loop;

      put(" ");

      --For loop to put the fourth set of 4 Bits of the mantissa for col 2
      for kk in reverse 8 .. 11 loop
         --for kk in 13 .. 16 loop

         put(mantissaArray(kk), width => 1);

      end loop;

      put(" ");

      --For loop to put the first 4 Bits of  the mantissa for col 2
      for mm in reverse 4 .. 7 loop
         --for mm in 17 .. 20 loop

         put(mantissaArray(mm), width => 1);

      end loop;

      put(" ");

      --For loop to put the first 4 Bits of  the mantissa for col 2
      for nn in reverse 1 .. 3 loop
         --for nn in 21 .. 23 loop

         put(mantissaArray(nn), width => 1);

      end loop;

      put("E");

      exponent := calculateExponent(exponentArray);

      put(exponent, width => 3);

      put("   ");

   end print_Row1_Col2;

   procedure print_Row3_Col1 (float3: in out float) is

      originalFloat_Array1: BitString;
      row3_Array: BitString;
      indexCount1: Natural := 0;
      calculatedNumber_Row3_Col1: Unsigned := 0;
      fff: Float;

   begin

      originalFloat_Array1 := convertFloatToBitString(float3);

       for y in 1 .. 23 loop

         if(originalFloat_Array1(y) = 1) then

              calculatedNumber_Row3_Col1 := calculatedNumber_Row3_Col1 + 2**indexCount1;

         end if;

         indexCount1 := indexCount1 + 1;

      end loop;

      for q in reverse 24 .. 31 loop

         if(originalFloat_Array1(q) = 1) then

              calculatedNumber_Row3_Col1 := calculatedNumber_Row3_Col1 + 2**indexCount1;

         end if;

         indexCount1 := indexCount1 + 1;

      end loop;

       for z in 32 .. 32 loop

         if(originalFloat_Array1(z) = 1) then

            calculatedNumber_Row3_Col1 := calculatedNumber_Row3_Col1 + 2**indexCount1;

         end if;

         indexCount1 := indexCount1 + 1;

      end loop;

      fff := convertUnsignedToFloat(calculatedNumber_Row3_Col1);

      put(fff);

      put("  ");

      row3_Array := convertFloatToBitString(fff);

      print_Row3_Col2(row3_Array);

   end print_Row3_Col1;

   procedure print_Row2_Col1 (float2: in out float) is

      originalFloat_Array: BitString;
      inversedFloat_Array: BitString;
      indexCount: Integer := 1;
      ff: Float;

   begin
      originalFloat_Array := convertFloatToBitString(float2);

      for q in reverse originalFloat_Array'First .. originalFloat_Array'Last loop

         inversedFloat_Array(indexCount) := originalFloat_Array(q);
         indexCount := indexCount + 1;

      end loop;

      ff := convertBitStringToFloat(inversedFloat_Array);

      put(ff);

      put("  ");

      print_Row2_Col2(inversedFloat_Array);

   end print_Row2_Col1;

   --This procedure takes in a float, prints it in scientific notation
   --then sends it to be converted into a BitString array
   procedure print_Row1_Col1 (float1: in out float) is

      bitStringArray_Row1_Col2: BitString;
      bitStringArray_Row1_Col3: BitString;

   begin
      put(float1);--printing the original float
      put("  ");
      bitStringArray_Row1_Col2 := convertFloatToBitString(float1);--converting the float for column 2
      bitStringArray_Row1_Col3 := convertFloatToBitString(float1);--converting the float for column 3
      print_Row1_Col2(bitStringArray_Row1_Col2);--sending the BitString array to be printed in column 2
      print_Row1_Col3(bitStringArray_Row1_Col3);--sending the BitString array to be printed in column 3
   end print_Row1_Col1;

   f: float;

begin

   while not ada.Text_IO.End_Of_File loop

      get(f);
      print_Row1_Col1(f);
      print_Row2_Col1(f);
      print_Row3_Col1(f);
      Put_Line("------------------------------------------------------------------------------------------");

   end loop;

end floatflip;
