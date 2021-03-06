%PDDF: Pair Distance Distribution Function from r_start to r_end with r_intervals
%program by E.M. July 2013
%Bioinformatic toolbox is needed for pdbread function
%input: PDB_file can be retrived by 
%output: PDDF plot
 clear all
 clc;
 r_start=0;
 r_end=60; % unit Angstroms
 r_interval=1; % Angstroms
 N_interval=(r_end-r_start)/r_interval;
 PDDF=zeros(1,N_interval);
 r=linspace(r_start, r_end, N_interval);
 PDBfile='1EY0.pdb';
 %Reading the PDB file
 pdbstruct = pdbread(PDBfile);
 %Alternatively can be retrieved directly from rcsb
 %pdbstruct = pdbread('http://www.rcsb.org/pdb/files/1EY0.pdb');
 [m,nAtoms] = size(pdbstruct.Model.Atom);
 for i=1:nAtoms
     X1=pdbstruct.Model.Atom(1,i).X;
     Y1=pdbstruct.Model.Atom(1,i).Y;
     Z1=pdbstruct.Model.Atom(1,i).Z;
     for j=1:nAtoms
         if i==j
             continue
         end
         X2=pdbstruct.Model.Atom(1,j).X;
         Y2=pdbstruct.Model.Atom(1,j).Y;
         Z2=pdbstruct.Model.Atom(1,j).Z;
         distance = sqrt ((X2-X1)^2+(Y2-Y1)^2+(Z2-Z1)^2);
         indx = ceil(distance/r_interval);
         PDDF(indx)=PDDF(indx)+1;
     end
 end
 PDDF=PDDF/2; %Because each pair is calculated twice
 plot(r,PDDF);
