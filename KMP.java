import java.util.*;
import java.lang.*;
import java.io.*;
import java.util.Arrays;

class KMP
{
	public static void main (String[] args) throws java.lang.Exception
	{
		char[] P = {'a', 'b','a','b','a','b','a','b','c','a'};
		int[] pi = {0,0,0,0,0,0,0,0,0,0};
		
		pi[0] = -1;
		int k = 0;
		
		for(int i = 1; i < P.length; i++) {
			while(k>= 0 && P[k] != P[i]) {
				k = pi[k];
			}
			pi[i] = k;
			k++;
		}
		System.out.println(Arrays.toString(pi));
		
		k = 0;
		char[] T = "zzz ababababca ababababcd ababababca ababababca".toCharArray();
		for(int i = 0; i < T.length; i++) {
			System.out.println("Starting at: " + k);
			while(k>= 0 && P[k] != T[i]) {
				System.out.println("Mismatch at: " + k + " expected " + P[k] + " got " + T[i]);
				k = pi[k];
				System.out.println("Shifted to " + k);
			}
			k++;
			if(k == P.length) {
				System.out.println("Match found at " + i +"-"+ k);
				k = pi[k - 1];
			}
		}
	} 
}
