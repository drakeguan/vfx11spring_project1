function imgRGBE=float2RGBE(img)
%
%       imgRGBE=float2RGBE(img)
%
%
%        Input:
%           -img: a HDR image in RGB single float format
%
%        Output:
%           -imgRGBE: the HDR image encoded using the RGBE format
%
%     Copyright (C) 2011  Francesco Banterle
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

[m,n,c]=size(img);
imgRGBE=zeros(m,n,4);

v=max(img,[],3);

Low=find(v<1e-32);

v2=v;
[v,e] = log2(v);
e=e+128;
v=v*256./v2;
v(Low)=0;
e(Low)=0;

for i=1:3
    imgRGBE(:,:,i)=round(img(:,:,i).*v);
end

imgRGBE(:,:,4)=e;

end