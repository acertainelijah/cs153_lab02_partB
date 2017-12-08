
_shm_cnt:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
   struct uspinlock lock;
   int cnt;
};

int main(int argc, char *argv[])
{
    1000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    1004:	83 e4 f0             	and    $0xfffffff0,%esp
    1007:	ff 71 fc             	pushl  -0x4(%ecx)
    100a:	55                   	push   %ebp
    100b:	89 e5                	mov    %esp,%ebp
    100d:	57                   	push   %edi
    100e:	56                   	push   %esi
    100f:	53                   	push   %ebx
    1010:	51                   	push   %ecx
    1011:	83 ec 28             	sub    $0x28,%esp
int pid;
int i=0;
struct shm_cnt *counter;
  pid=fork();
    1014:	e8 91 03 00 00       	call   13aa <fork>
  sleep(1);
    1019:	83 ec 0c             	sub    $0xc,%esp
int main(int argc, char *argv[])
{
int pid;
int i=0;
struct shm_cnt *counter;
  pid=fork();
    101c:	89 c6                	mov    %eax,%esi
    101e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  sleep(1);
    1021:	6a 01                	push   $0x1
    1023:	e8 1a 04 00 00       	call   1442 <sleep>

//shm_open: first process will create the page, the second will just attach to the same page
//we get the virtual address of the page returned into counter
//which we can now use but will be shared between the two processes
printf(1,"%s calling shm_open now. Counter: %x\n", pid? "Child": "Parent", counter); 
    1028:	83 c4 10             	add    $0x10,%esp
    102b:	85 f6                	test   %esi,%esi
    102d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1030:	0f 84 e5 00 00 00    	je     111b <main+0x11b>
    1036:	50                   	push   %eax
    1037:	68 64 18 00 00       	push   $0x1864
    103c:	be 6a 18 00 00       	mov    $0x186a,%esi
    1041:	68 00 19 00 00       	push   $0x1900
    1046:	6a 01                	push   $0x1
    1048:	e8 c3 04 00 00       	call   1510 <printf>
  
shm_open(1,(char **)&counter);
    104d:	59                   	pop    %ecx
    104e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1051:	5b                   	pop    %ebx
    1052:	50                   	push   %eax
    1053:	6a 01                	push   $0x1
 
printf(1,"%s returned successfully from shm_open with counter %x\n", pid? "Child": "Parent", counter); 
    1055:	bb 64 18 00 00       	mov    $0x1864,%ebx
//shm_open: first process will create the page, the second will just attach to the same page
//we get the virtual address of the page returned into counter
//which we can now use but will be shared between the two processes
printf(1,"%s calling shm_open now. Counter: %x\n", pid? "Child": "Parent", counter); 
  
shm_open(1,(char **)&counter);
    105a:	e8 f3 03 00 00       	call   1452 <shm_open>
 
printf(1,"%s returned successfully from shm_open with counter %x\n", pid? "Child": "Parent", counter); 
    105f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1062:	83 c4 10             	add    $0x10,%esp
    1065:	89 d8                	mov    %ebx,%eax
    1067:	52                   	push   %edx
    1068:	50                   	push   %eax
    1069:	68 a4 18 00 00       	push   $0x18a4
    106e:	6a 01                	push   $0x1
    1070:	e8 9b 04 00 00       	call   1510 <printf>
    1075:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1078:	83 c4 10             	add    $0x10,%esp
    107b:	85 c0                	test   %eax,%eax
    107d:	0f 44 f3             	cmove  %ebx,%esi
  for(i = 0; i < 10000; i++)
    1080:	31 ff                	xor    %edi,%edi
     uacquire(&(counter->lock));
     counter->cnt++;
     urelease(&(counter->lock));

//print something because we are curious and to give a chance to switch process
     if(i%1000 == 0)
    1082:	bb d3 4d 62 10       	mov    $0x10624dd3,%ebx
    1087:	89 f6                	mov    %esi,%esi
    1089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
shm_open(1,(char **)&counter);
 
printf(1,"%s returned successfully from shm_open with counter %x\n", pid? "Child": "Parent", counter); 
  for(i = 0; i < 10000; i++)
    {
     uacquire(&(counter->lock));
    1090:	83 ec 0c             	sub    $0xc,%esp
    1093:	ff 75 e4             	pushl  -0x1c(%ebp)
    1096:	e8 95 07 00 00       	call   1830 <uacquire>
     counter->cnt++;
    109b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    109e:	83 40 04 01          	addl   $0x1,0x4(%eax)
     urelease(&(counter->lock));
    10a2:	89 04 24             	mov    %eax,(%esp)
    10a5:	e8 a6 07 00 00       	call   1850 <urelease>

//print something because we are curious and to give a chance to switch process
     if(i%1000 == 0)
    10aa:	89 f8                	mov    %edi,%eax
    10ac:	83 c4 10             	add    $0x10,%esp
    10af:	f7 eb                	imul   %ebx
    10b1:	89 f8                	mov    %edi,%eax
    10b3:	c1 f8 1f             	sar    $0x1f,%eax
    10b6:	c1 fa 06             	sar    $0x6,%edx
    10b9:	29 c2                	sub    %eax,%edx
    10bb:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    10c1:	39 d7                	cmp    %edx,%edi
    10c3:	75 1a                	jne    10df <main+0xdf>
       printf(1,"Counter in %s is %d at address %x\n",pid? "Parent" : "Child", counter->cnt, counter);
    10c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10c8:	83 ec 0c             	sub    $0xc,%esp
    10cb:	50                   	push   %eax
    10cc:	ff 70 04             	pushl  0x4(%eax)
    10cf:	56                   	push   %esi
    10d0:	68 dc 18 00 00       	push   $0x18dc
    10d5:	6a 01                	push   $0x1
    10d7:	e8 34 04 00 00       	call   1510 <printf>
    10dc:	83 c4 20             	add    $0x20,%esp
printf(1,"%s calling shm_open now. Counter: %x\n", pid? "Child": "Parent", counter); 
  
shm_open(1,(char **)&counter);
 
printf(1,"%s returned successfully from shm_open with counter %x\n", pid? "Child": "Parent", counter); 
  for(i = 0; i < 10000; i++)
    10df:	83 c7 01             	add    $0x1,%edi
    10e2:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
    10e8:	75 a6                	jne    1090 <main+0x90>
//print something because we are curious and to give a chance to switch process
     if(i%1000 == 0)
       printf(1,"Counter in %s is %d at address %x\n",pid? "Parent" : "Child", counter->cnt, counter);
}
  
  if(pid)
    10ea:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    10ed:	85 c0                	test   %eax,%eax
    10ef:	74 60                	je     1151 <main+0x151>
     {
       printf(1,"Counter in parent is %d\n",counter->cnt);
    10f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10f4:	57                   	push   %edi
    10f5:	ff 70 04             	pushl  0x4(%eax)
    10f8:	68 71 18 00 00       	push   $0x1871
    10fd:	6a 01                	push   $0x1
    10ff:	e8 0c 04 00 00       	call   1510 <printf>
    wait();
    1104:	e8 b1 02 00 00       	call   13ba <wait>
    1109:	83 c4 10             	add    $0x10,%esp
    } else
    printf(1,"Counter in child is %d\n\n",counter->cnt);

//shm_close: first process will just detach, next one will free up the shm_table entry (but for now not the page)
   shm_close(1);
    110c:	83 ec 0c             	sub    $0xc,%esp
    110f:	6a 01                	push   $0x1
    1111:	e8 44 03 00 00       	call   145a <shm_close>
   exit();
    1116:	e8 97 02 00 00       	call   13b2 <exit>
  sleep(1);

//shm_open: first process will create the page, the second will just attach to the same page
//we get the virtual address of the page returned into counter
//which we can now use but will be shared between the two processes
printf(1,"%s calling shm_open now. Counter: %x\n", pid? "Child": "Parent", counter); 
    111b:	50                   	push   %eax
    111c:	68 6a 18 00 00       	push   $0x186a
  
shm_open(1,(char **)&counter);
 
printf(1,"%s returned successfully from shm_open with counter %x\n", pid? "Child": "Parent", counter); 
    1121:	be 6a 18 00 00       	mov    $0x186a,%esi
  sleep(1);

//shm_open: first process will create the page, the second will just attach to the same page
//we get the virtual address of the page returned into counter
//which we can now use but will be shared between the two processes
printf(1,"%s calling shm_open now. Counter: %x\n", pid? "Child": "Parent", counter); 
    1126:	68 00 19 00 00       	push   $0x1900
    112b:	6a 01                	push   $0x1
    112d:	bb 64 18 00 00       	mov    $0x1864,%ebx
    1132:	e8 d9 03 00 00       	call   1510 <printf>
  
shm_open(1,(char **)&counter);
    1137:	58                   	pop    %eax
    1138:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    113b:	5a                   	pop    %edx
    113c:	50                   	push   %eax
    113d:	6a 01                	push   $0x1
    113f:	e8 0e 03 00 00       	call   1452 <shm_open>
 
printf(1,"%s returned successfully from shm_open with counter %x\n", pid? "Child": "Parent", counter); 
    1144:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1147:	83 c4 10             	add    $0x10,%esp
    114a:	89 f0                	mov    %esi,%eax
    114c:	e9 16 ff ff ff       	jmp    1067 <main+0x67>
  if(pid)
     {
       printf(1,"Counter in parent is %d\n",counter->cnt);
    wait();
    } else
    printf(1,"Counter in child is %d\n\n",counter->cnt);
    1151:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1154:	56                   	push   %esi
    1155:	ff 70 04             	pushl  0x4(%eax)
    1158:	68 8a 18 00 00       	push   $0x188a
    115d:	6a 01                	push   $0x1
    115f:	e8 ac 03 00 00       	call   1510 <printf>
    1164:	83 c4 10             	add    $0x10,%esp
    1167:	eb a3                	jmp    110c <main+0x10c>
    1169:	66 90                	xchg   %ax,%ax
    116b:	66 90                	xchg   %ax,%ax
    116d:	66 90                	xchg   %ax,%ax
    116f:	90                   	nop

00001170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	53                   	push   %ebx
    1174:	8b 45 08             	mov    0x8(%ebp),%eax
    1177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    117a:	89 c2                	mov    %eax,%edx
    117c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1180:	83 c1 01             	add    $0x1,%ecx
    1183:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1187:	83 c2 01             	add    $0x1,%edx
    118a:	84 db                	test   %bl,%bl
    118c:	88 5a ff             	mov    %bl,-0x1(%edx)
    118f:	75 ef                	jne    1180 <strcpy+0x10>
    ;
  return os;
}
    1191:	5b                   	pop    %ebx
    1192:	5d                   	pop    %ebp
    1193:	c3                   	ret    
    1194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    119a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000011a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	56                   	push   %esi
    11a4:	53                   	push   %ebx
    11a5:	8b 55 08             	mov    0x8(%ebp),%edx
    11a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    11ab:	0f b6 02             	movzbl (%edx),%eax
    11ae:	0f b6 19             	movzbl (%ecx),%ebx
    11b1:	84 c0                	test   %al,%al
    11b3:	75 1e                	jne    11d3 <strcmp+0x33>
    11b5:	eb 29                	jmp    11e0 <strcmp+0x40>
    11b7:	89 f6                	mov    %esi,%esi
    11b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    11c0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    11c6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11c9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    11cd:	84 c0                	test   %al,%al
    11cf:	74 0f                	je     11e0 <strcmp+0x40>
    11d1:	89 f1                	mov    %esi,%ecx
    11d3:	38 d8                	cmp    %bl,%al
    11d5:	74 e9                	je     11c0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    11d7:	29 d8                	sub    %ebx,%eax
}
    11d9:	5b                   	pop    %ebx
    11da:	5e                   	pop    %esi
    11db:	5d                   	pop    %ebp
    11dc:	c3                   	ret    
    11dd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    11e0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    11e2:	29 d8                	sub    %ebx,%eax
}
    11e4:	5b                   	pop    %ebx
    11e5:	5e                   	pop    %esi
    11e6:	5d                   	pop    %ebp
    11e7:	c3                   	ret    
    11e8:	90                   	nop
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000011f0 <strlen>:

uint
strlen(char *s)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11f6:	80 39 00             	cmpb   $0x0,(%ecx)
    11f9:	74 12                	je     120d <strlen+0x1d>
    11fb:	31 d2                	xor    %edx,%edx
    11fd:	8d 76 00             	lea    0x0(%esi),%esi
    1200:	83 c2 01             	add    $0x1,%edx
    1203:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1207:	89 d0                	mov    %edx,%eax
    1209:	75 f5                	jne    1200 <strlen+0x10>
    ;
  return n;
}
    120b:	5d                   	pop    %ebp
    120c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    120d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    120f:	5d                   	pop    %ebp
    1210:	c3                   	ret    
    1211:	eb 0d                	jmp    1220 <memset>
    1213:	90                   	nop
    1214:	90                   	nop
    1215:	90                   	nop
    1216:	90                   	nop
    1217:	90                   	nop
    1218:	90                   	nop
    1219:	90                   	nop
    121a:	90                   	nop
    121b:	90                   	nop
    121c:	90                   	nop
    121d:	90                   	nop
    121e:	90                   	nop
    121f:	90                   	nop

00001220 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1227:	8b 4d 10             	mov    0x10(%ebp),%ecx
    122a:	8b 45 0c             	mov    0xc(%ebp),%eax
    122d:	89 d7                	mov    %edx,%edi
    122f:	fc                   	cld    
    1230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1232:	89 d0                	mov    %edx,%eax
    1234:	5f                   	pop    %edi
    1235:	5d                   	pop    %ebp
    1236:	c3                   	ret    
    1237:	89 f6                	mov    %esi,%esi
    1239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001240 <strchr>:

char*
strchr(const char *s, char c)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	53                   	push   %ebx
    1244:	8b 45 08             	mov    0x8(%ebp),%eax
    1247:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    124a:	0f b6 10             	movzbl (%eax),%edx
    124d:	84 d2                	test   %dl,%dl
    124f:	74 1d                	je     126e <strchr+0x2e>
    if(*s == c)
    1251:	38 d3                	cmp    %dl,%bl
    1253:	89 d9                	mov    %ebx,%ecx
    1255:	75 0d                	jne    1264 <strchr+0x24>
    1257:	eb 17                	jmp    1270 <strchr+0x30>
    1259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1260:	38 ca                	cmp    %cl,%dl
    1262:	74 0c                	je     1270 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1264:	83 c0 01             	add    $0x1,%eax
    1267:	0f b6 10             	movzbl (%eax),%edx
    126a:	84 d2                	test   %dl,%dl
    126c:	75 f2                	jne    1260 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    126e:	31 c0                	xor    %eax,%eax
}
    1270:	5b                   	pop    %ebx
    1271:	5d                   	pop    %ebp
    1272:	c3                   	ret    
    1273:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001280 <gets>:

char*
gets(char *buf, int max)
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	57                   	push   %edi
    1284:	56                   	push   %esi
    1285:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1286:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    1288:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    128b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    128e:	eb 29                	jmp    12b9 <gets+0x39>
    cc = read(0, &c, 1);
    1290:	83 ec 04             	sub    $0x4,%esp
    1293:	6a 01                	push   $0x1
    1295:	57                   	push   %edi
    1296:	6a 00                	push   $0x0
    1298:	e8 2d 01 00 00       	call   13ca <read>
    if(cc < 1)
    129d:	83 c4 10             	add    $0x10,%esp
    12a0:	85 c0                	test   %eax,%eax
    12a2:	7e 1d                	jle    12c1 <gets+0x41>
      break;
    buf[i++] = c;
    12a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    12a8:	8b 55 08             	mov    0x8(%ebp),%edx
    12ab:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    12ad:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    12af:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    12b3:	74 1b                	je     12d0 <gets+0x50>
    12b5:	3c 0d                	cmp    $0xd,%al
    12b7:	74 17                	je     12d0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12b9:	8d 5e 01             	lea    0x1(%esi),%ebx
    12bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    12bf:	7c cf                	jl     1290 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    12c1:	8b 45 08             	mov    0x8(%ebp),%eax
    12c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    12c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12cb:	5b                   	pop    %ebx
    12cc:	5e                   	pop    %esi
    12cd:	5f                   	pop    %edi
    12ce:	5d                   	pop    %ebp
    12cf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    12d0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12d3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    12d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    12d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12dc:	5b                   	pop    %ebx
    12dd:	5e                   	pop    %esi
    12de:	5f                   	pop    %edi
    12df:	5d                   	pop    %ebp
    12e0:	c3                   	ret    
    12e1:	eb 0d                	jmp    12f0 <stat>
    12e3:	90                   	nop
    12e4:	90                   	nop
    12e5:	90                   	nop
    12e6:	90                   	nop
    12e7:	90                   	nop
    12e8:	90                   	nop
    12e9:	90                   	nop
    12ea:	90                   	nop
    12eb:	90                   	nop
    12ec:	90                   	nop
    12ed:	90                   	nop
    12ee:	90                   	nop
    12ef:	90                   	nop

000012f0 <stat>:

int
stat(char *n, struct stat *st)
{
    12f0:	55                   	push   %ebp
    12f1:	89 e5                	mov    %esp,%ebp
    12f3:	56                   	push   %esi
    12f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12f5:	83 ec 08             	sub    $0x8,%esp
    12f8:	6a 00                	push   $0x0
    12fa:	ff 75 08             	pushl  0x8(%ebp)
    12fd:	e8 f0 00 00 00       	call   13f2 <open>
  if(fd < 0)
    1302:	83 c4 10             	add    $0x10,%esp
    1305:	85 c0                	test   %eax,%eax
    1307:	78 27                	js     1330 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1309:	83 ec 08             	sub    $0x8,%esp
    130c:	ff 75 0c             	pushl  0xc(%ebp)
    130f:	89 c3                	mov    %eax,%ebx
    1311:	50                   	push   %eax
    1312:	e8 f3 00 00 00       	call   140a <fstat>
    1317:	89 c6                	mov    %eax,%esi
  close(fd);
    1319:	89 1c 24             	mov    %ebx,(%esp)
    131c:	e8 b9 00 00 00       	call   13da <close>
  return r;
    1321:	83 c4 10             	add    $0x10,%esp
    1324:	89 f0                	mov    %esi,%eax
}
    1326:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1329:	5b                   	pop    %ebx
    132a:	5e                   	pop    %esi
    132b:	5d                   	pop    %ebp
    132c:	c3                   	ret    
    132d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    1330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1335:	eb ef                	jmp    1326 <stat+0x36>
    1337:	89 f6                	mov    %esi,%esi
    1339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001340 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	53                   	push   %ebx
    1344:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1347:	0f be 11             	movsbl (%ecx),%edx
    134a:	8d 42 d0             	lea    -0x30(%edx),%eax
    134d:	3c 09                	cmp    $0x9,%al
    134f:	b8 00 00 00 00       	mov    $0x0,%eax
    1354:	77 1f                	ja     1375 <atoi+0x35>
    1356:	8d 76 00             	lea    0x0(%esi),%esi
    1359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1360:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1363:	83 c1 01             	add    $0x1,%ecx
    1366:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    136a:	0f be 11             	movsbl (%ecx),%edx
    136d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1370:	80 fb 09             	cmp    $0x9,%bl
    1373:	76 eb                	jbe    1360 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    1375:	5b                   	pop    %ebx
    1376:	5d                   	pop    %ebp
    1377:	c3                   	ret    
    1378:	90                   	nop
    1379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001380 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	56                   	push   %esi
    1384:	53                   	push   %ebx
    1385:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1388:	8b 45 08             	mov    0x8(%ebp),%eax
    138b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    138e:	85 db                	test   %ebx,%ebx
    1390:	7e 14                	jle    13a6 <memmove+0x26>
    1392:	31 d2                	xor    %edx,%edx
    1394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1398:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    139c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    139f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    13a2:	39 da                	cmp    %ebx,%edx
    13a4:	75 f2                	jne    1398 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    13a6:	5b                   	pop    %ebx
    13a7:	5e                   	pop    %esi
    13a8:	5d                   	pop    %ebp
    13a9:	c3                   	ret    

000013aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13aa:	b8 01 00 00 00       	mov    $0x1,%eax
    13af:	cd 40                	int    $0x40
    13b1:	c3                   	ret    

000013b2 <exit>:
SYSCALL(exit)
    13b2:	b8 02 00 00 00       	mov    $0x2,%eax
    13b7:	cd 40                	int    $0x40
    13b9:	c3                   	ret    

000013ba <wait>:
SYSCALL(wait)
    13ba:	b8 03 00 00 00       	mov    $0x3,%eax
    13bf:	cd 40                	int    $0x40
    13c1:	c3                   	ret    

000013c2 <pipe>:
SYSCALL(pipe)
    13c2:	b8 04 00 00 00       	mov    $0x4,%eax
    13c7:	cd 40                	int    $0x40
    13c9:	c3                   	ret    

000013ca <read>:
SYSCALL(read)
    13ca:	b8 05 00 00 00       	mov    $0x5,%eax
    13cf:	cd 40                	int    $0x40
    13d1:	c3                   	ret    

000013d2 <write>:
SYSCALL(write)
    13d2:	b8 10 00 00 00       	mov    $0x10,%eax
    13d7:	cd 40                	int    $0x40
    13d9:	c3                   	ret    

000013da <close>:
SYSCALL(close)
    13da:	b8 15 00 00 00       	mov    $0x15,%eax
    13df:	cd 40                	int    $0x40
    13e1:	c3                   	ret    

000013e2 <kill>:
SYSCALL(kill)
    13e2:	b8 06 00 00 00       	mov    $0x6,%eax
    13e7:	cd 40                	int    $0x40
    13e9:	c3                   	ret    

000013ea <exec>:
SYSCALL(exec)
    13ea:	b8 07 00 00 00       	mov    $0x7,%eax
    13ef:	cd 40                	int    $0x40
    13f1:	c3                   	ret    

000013f2 <open>:
SYSCALL(open)
    13f2:	b8 0f 00 00 00       	mov    $0xf,%eax
    13f7:	cd 40                	int    $0x40
    13f9:	c3                   	ret    

000013fa <mknod>:
SYSCALL(mknod)
    13fa:	b8 11 00 00 00       	mov    $0x11,%eax
    13ff:	cd 40                	int    $0x40
    1401:	c3                   	ret    

00001402 <unlink>:
SYSCALL(unlink)
    1402:	b8 12 00 00 00       	mov    $0x12,%eax
    1407:	cd 40                	int    $0x40
    1409:	c3                   	ret    

0000140a <fstat>:
SYSCALL(fstat)
    140a:	b8 08 00 00 00       	mov    $0x8,%eax
    140f:	cd 40                	int    $0x40
    1411:	c3                   	ret    

00001412 <link>:
SYSCALL(link)
    1412:	b8 13 00 00 00       	mov    $0x13,%eax
    1417:	cd 40                	int    $0x40
    1419:	c3                   	ret    

0000141a <mkdir>:
SYSCALL(mkdir)
    141a:	b8 14 00 00 00       	mov    $0x14,%eax
    141f:	cd 40                	int    $0x40
    1421:	c3                   	ret    

00001422 <chdir>:
SYSCALL(chdir)
    1422:	b8 09 00 00 00       	mov    $0x9,%eax
    1427:	cd 40                	int    $0x40
    1429:	c3                   	ret    

0000142a <dup>:
SYSCALL(dup)
    142a:	b8 0a 00 00 00       	mov    $0xa,%eax
    142f:	cd 40                	int    $0x40
    1431:	c3                   	ret    

00001432 <getpid>:
SYSCALL(getpid)
    1432:	b8 0b 00 00 00       	mov    $0xb,%eax
    1437:	cd 40                	int    $0x40
    1439:	c3                   	ret    

0000143a <sbrk>:
SYSCALL(sbrk)
    143a:	b8 0c 00 00 00       	mov    $0xc,%eax
    143f:	cd 40                	int    $0x40
    1441:	c3                   	ret    

00001442 <sleep>:
SYSCALL(sleep)
    1442:	b8 0d 00 00 00       	mov    $0xd,%eax
    1447:	cd 40                	int    $0x40
    1449:	c3                   	ret    

0000144a <uptime>:
SYSCALL(uptime)
    144a:	b8 0e 00 00 00       	mov    $0xe,%eax
    144f:	cd 40                	int    $0x40
    1451:	c3                   	ret    

00001452 <shm_open>:
SYSCALL(shm_open)
    1452:	b8 16 00 00 00       	mov    $0x16,%eax
    1457:	cd 40                	int    $0x40
    1459:	c3                   	ret    

0000145a <shm_close>:
SYSCALL(shm_close)	
    145a:	b8 17 00 00 00       	mov    $0x17,%eax
    145f:	cd 40                	int    $0x40
    1461:	c3                   	ret    
    1462:	66 90                	xchg   %ax,%ax
    1464:	66 90                	xchg   %ax,%ax
    1466:	66 90                	xchg   %ax,%ax
    1468:	66 90                	xchg   %ax,%ax
    146a:	66 90                	xchg   %ax,%ax
    146c:	66 90                	xchg   %ax,%ax
    146e:	66 90                	xchg   %ax,%ax

00001470 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	57                   	push   %edi
    1474:	56                   	push   %esi
    1475:	53                   	push   %ebx
    1476:	89 c6                	mov    %eax,%esi
    1478:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    147b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    147e:	85 db                	test   %ebx,%ebx
    1480:	74 7e                	je     1500 <printint+0x90>
    1482:	89 d0                	mov    %edx,%eax
    1484:	c1 e8 1f             	shr    $0x1f,%eax
    1487:	84 c0                	test   %al,%al
    1489:	74 75                	je     1500 <printint+0x90>
    neg = 1;
    x = -xx;
    148b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    148d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    1494:	f7 d8                	neg    %eax
    1496:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1499:	31 ff                	xor    %edi,%edi
    149b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    149e:	89 ce                	mov    %ecx,%esi
    14a0:	eb 08                	jmp    14aa <printint+0x3a>
    14a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    14a8:	89 cf                	mov    %ecx,%edi
    14aa:	31 d2                	xor    %edx,%edx
    14ac:	8d 4f 01             	lea    0x1(%edi),%ecx
    14af:	f7 f6                	div    %esi
    14b1:	0f b6 92 30 19 00 00 	movzbl 0x1930(%edx),%edx
  }while((x /= base) != 0);
    14b8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    14ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    14bd:	75 e9                	jne    14a8 <printint+0x38>
  if(neg)
    14bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    14c2:	8b 75 c0             	mov    -0x40(%ebp),%esi
    14c5:	85 c0                	test   %eax,%eax
    14c7:	74 08                	je     14d1 <printint+0x61>
    buf[i++] = '-';
    14c9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    14ce:	8d 4f 02             	lea    0x2(%edi),%ecx
    14d1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    14d5:	8d 76 00             	lea    0x0(%esi),%esi
    14d8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    14db:	83 ec 04             	sub    $0x4,%esp
    14de:	83 ef 01             	sub    $0x1,%edi
    14e1:	6a 01                	push   $0x1
    14e3:	53                   	push   %ebx
    14e4:	56                   	push   %esi
    14e5:	88 45 d7             	mov    %al,-0x29(%ebp)
    14e8:	e8 e5 fe ff ff       	call   13d2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14ed:	83 c4 10             	add    $0x10,%esp
    14f0:	39 df                	cmp    %ebx,%edi
    14f2:	75 e4                	jne    14d8 <printint+0x68>
    putc(fd, buf[i]);
}
    14f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14f7:	5b                   	pop    %ebx
    14f8:	5e                   	pop    %esi
    14f9:	5f                   	pop    %edi
    14fa:	5d                   	pop    %ebp
    14fb:	c3                   	ret    
    14fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1500:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1502:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1509:	eb 8b                	jmp    1496 <printint+0x26>
    150b:	90                   	nop
    150c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001510 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	57                   	push   %edi
    1514:	56                   	push   %esi
    1515:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1516:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1519:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    151c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    151f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1522:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1525:	0f b6 1e             	movzbl (%esi),%ebx
    1528:	83 c6 01             	add    $0x1,%esi
    152b:	84 db                	test   %bl,%bl
    152d:	0f 84 b0 00 00 00    	je     15e3 <printf+0xd3>
    1533:	31 d2                	xor    %edx,%edx
    1535:	eb 39                	jmp    1570 <printf+0x60>
    1537:	89 f6                	mov    %esi,%esi
    1539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1540:	83 f8 25             	cmp    $0x25,%eax
    1543:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1546:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    154b:	74 18                	je     1565 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    154d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1550:	83 ec 04             	sub    $0x4,%esp
    1553:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1556:	6a 01                	push   $0x1
    1558:	50                   	push   %eax
    1559:	57                   	push   %edi
    155a:	e8 73 fe ff ff       	call   13d2 <write>
    155f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1562:	83 c4 10             	add    $0x10,%esp
    1565:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1568:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    156c:	84 db                	test   %bl,%bl
    156e:	74 73                	je     15e3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    1570:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1572:	0f be cb             	movsbl %bl,%ecx
    1575:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1578:	74 c6                	je     1540 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    157a:	83 fa 25             	cmp    $0x25,%edx
    157d:	75 e6                	jne    1565 <printf+0x55>
      if(c == 'd'){
    157f:	83 f8 64             	cmp    $0x64,%eax
    1582:	0f 84 f8 00 00 00    	je     1680 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1588:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    158e:	83 f9 70             	cmp    $0x70,%ecx
    1591:	74 5d                	je     15f0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1593:	83 f8 73             	cmp    $0x73,%eax
    1596:	0f 84 84 00 00 00    	je     1620 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    159c:	83 f8 63             	cmp    $0x63,%eax
    159f:	0f 84 ea 00 00 00    	je     168f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    15a5:	83 f8 25             	cmp    $0x25,%eax
    15a8:	0f 84 c2 00 00 00    	je     1670 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15ae:	8d 45 e7             	lea    -0x19(%ebp),%eax
    15b1:	83 ec 04             	sub    $0x4,%esp
    15b4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    15b8:	6a 01                	push   $0x1
    15ba:	50                   	push   %eax
    15bb:	57                   	push   %edi
    15bc:	e8 11 fe ff ff       	call   13d2 <write>
    15c1:	83 c4 0c             	add    $0xc,%esp
    15c4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    15c7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    15ca:	6a 01                	push   $0x1
    15cc:	50                   	push   %eax
    15cd:	57                   	push   %edi
    15ce:	83 c6 01             	add    $0x1,%esi
    15d1:	e8 fc fd ff ff       	call   13d2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15d6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    15da:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    15dd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15df:	84 db                	test   %bl,%bl
    15e1:	75 8d                	jne    1570 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15e6:	5b                   	pop    %ebx
    15e7:	5e                   	pop    %esi
    15e8:	5f                   	pop    %edi
    15e9:	5d                   	pop    %ebp
    15ea:	c3                   	ret    
    15eb:	90                   	nop
    15ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    15f0:	83 ec 0c             	sub    $0xc,%esp
    15f3:	b9 10 00 00 00       	mov    $0x10,%ecx
    15f8:	6a 00                	push   $0x0
    15fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    15fd:	89 f8                	mov    %edi,%eax
    15ff:	8b 13                	mov    (%ebx),%edx
    1601:	e8 6a fe ff ff       	call   1470 <printint>
        ap++;
    1606:	89 d8                	mov    %ebx,%eax
    1608:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    160b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    160d:	83 c0 04             	add    $0x4,%eax
    1610:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1613:	e9 4d ff ff ff       	jmp    1565 <printf+0x55>
    1618:	90                   	nop
    1619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1620:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1623:	8b 18                	mov    (%eax),%ebx
        ap++;
    1625:	83 c0 04             	add    $0x4,%eax
    1628:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    162b:	b8 28 19 00 00       	mov    $0x1928,%eax
    1630:	85 db                	test   %ebx,%ebx
    1632:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1635:	0f b6 03             	movzbl (%ebx),%eax
    1638:	84 c0                	test   %al,%al
    163a:	74 23                	je     165f <printf+0x14f>
    163c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1640:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1643:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1646:	83 ec 04             	sub    $0x4,%esp
    1649:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    164b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    164e:	50                   	push   %eax
    164f:	57                   	push   %edi
    1650:	e8 7d fd ff ff       	call   13d2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1655:	0f b6 03             	movzbl (%ebx),%eax
    1658:	83 c4 10             	add    $0x10,%esp
    165b:	84 c0                	test   %al,%al
    165d:	75 e1                	jne    1640 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    165f:	31 d2                	xor    %edx,%edx
    1661:	e9 ff fe ff ff       	jmp    1565 <printf+0x55>
    1666:	8d 76 00             	lea    0x0(%esi),%esi
    1669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1670:	83 ec 04             	sub    $0x4,%esp
    1673:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1676:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1679:	6a 01                	push   $0x1
    167b:	e9 4c ff ff ff       	jmp    15cc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1680:	83 ec 0c             	sub    $0xc,%esp
    1683:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1688:	6a 01                	push   $0x1
    168a:	e9 6b ff ff ff       	jmp    15fa <printf+0xea>
    168f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1692:	83 ec 04             	sub    $0x4,%esp
    1695:	8b 03                	mov    (%ebx),%eax
    1697:	6a 01                	push   $0x1
    1699:	88 45 e4             	mov    %al,-0x1c(%ebp)
    169c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    169f:	50                   	push   %eax
    16a0:	57                   	push   %edi
    16a1:	e8 2c fd ff ff       	call   13d2 <write>
    16a6:	e9 5b ff ff ff       	jmp    1606 <printf+0xf6>
    16ab:	66 90                	xchg   %ax,%ax
    16ad:	66 90                	xchg   %ax,%ax
    16af:	90                   	nop

000016b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16b1:	a1 14 1c 00 00       	mov    0x1c14,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    16b6:	89 e5                	mov    %esp,%ebp
    16b8:	57                   	push   %edi
    16b9:	56                   	push   %esi
    16ba:	53                   	push   %ebx
    16bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16be:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16c0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16c3:	39 c8                	cmp    %ecx,%eax
    16c5:	73 19                	jae    16e0 <free+0x30>
    16c7:	89 f6                	mov    %esi,%esi
    16c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    16d0:	39 d1                	cmp    %edx,%ecx
    16d2:	72 1c                	jb     16f0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16d4:	39 d0                	cmp    %edx,%eax
    16d6:	73 18                	jae    16f0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    16d8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16da:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16dc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16de:	72 f0                	jb     16d0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16e0:	39 d0                	cmp    %edx,%eax
    16e2:	72 f4                	jb     16d8 <free+0x28>
    16e4:	39 d1                	cmp    %edx,%ecx
    16e6:	73 f0                	jae    16d8 <free+0x28>
    16e8:	90                   	nop
    16e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    16f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    16f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    16f6:	39 d7                	cmp    %edx,%edi
    16f8:	74 19                	je     1713 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    16fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16fd:	8b 50 04             	mov    0x4(%eax),%edx
    1700:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1703:	39 f1                	cmp    %esi,%ecx
    1705:	74 23                	je     172a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1707:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1709:	a3 14 1c 00 00       	mov    %eax,0x1c14
}
    170e:	5b                   	pop    %ebx
    170f:	5e                   	pop    %esi
    1710:	5f                   	pop    %edi
    1711:	5d                   	pop    %ebp
    1712:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1713:	03 72 04             	add    0x4(%edx),%esi
    1716:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1719:	8b 10                	mov    (%eax),%edx
    171b:	8b 12                	mov    (%edx),%edx
    171d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1720:	8b 50 04             	mov    0x4(%eax),%edx
    1723:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1726:	39 f1                	cmp    %esi,%ecx
    1728:	75 dd                	jne    1707 <free+0x57>
    p->s.size += bp->s.size;
    172a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    172d:	a3 14 1c 00 00       	mov    %eax,0x1c14
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1732:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1735:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1738:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    173a:	5b                   	pop    %ebx
    173b:	5e                   	pop    %esi
    173c:	5f                   	pop    %edi
    173d:	5d                   	pop    %ebp
    173e:	c3                   	ret    
    173f:	90                   	nop

00001740 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1740:	55                   	push   %ebp
    1741:	89 e5                	mov    %esp,%ebp
    1743:	57                   	push   %edi
    1744:	56                   	push   %esi
    1745:	53                   	push   %ebx
    1746:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1749:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    174c:	8b 15 14 1c 00 00    	mov    0x1c14,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1752:	8d 78 07             	lea    0x7(%eax),%edi
    1755:	c1 ef 03             	shr    $0x3,%edi
    1758:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    175b:	85 d2                	test   %edx,%edx
    175d:	0f 84 a3 00 00 00    	je     1806 <malloc+0xc6>
    1763:	8b 02                	mov    (%edx),%eax
    1765:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1768:	39 cf                	cmp    %ecx,%edi
    176a:	76 74                	jbe    17e0 <malloc+0xa0>
    176c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1772:	be 00 10 00 00       	mov    $0x1000,%esi
    1777:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    177e:	0f 43 f7             	cmovae %edi,%esi
    1781:	ba 00 80 00 00       	mov    $0x8000,%edx
    1786:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    178c:	0f 46 da             	cmovbe %edx,%ebx
    178f:	eb 10                	jmp    17a1 <malloc+0x61>
    1791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1798:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    179a:	8b 48 04             	mov    0x4(%eax),%ecx
    179d:	39 cf                	cmp    %ecx,%edi
    179f:	76 3f                	jbe    17e0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17a1:	39 05 14 1c 00 00    	cmp    %eax,0x1c14
    17a7:	89 c2                	mov    %eax,%edx
    17a9:	75 ed                	jne    1798 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    17ab:	83 ec 0c             	sub    $0xc,%esp
    17ae:	53                   	push   %ebx
    17af:	e8 86 fc ff ff       	call   143a <sbrk>
  if(p == (char*)-1)
    17b4:	83 c4 10             	add    $0x10,%esp
    17b7:	83 f8 ff             	cmp    $0xffffffff,%eax
    17ba:	74 1c                	je     17d8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    17bc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    17bf:	83 ec 0c             	sub    $0xc,%esp
    17c2:	83 c0 08             	add    $0x8,%eax
    17c5:	50                   	push   %eax
    17c6:	e8 e5 fe ff ff       	call   16b0 <free>
  return freep;
    17cb:	8b 15 14 1c 00 00    	mov    0x1c14,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    17d1:	83 c4 10             	add    $0x10,%esp
    17d4:	85 d2                	test   %edx,%edx
    17d6:	75 c0                	jne    1798 <malloc+0x58>
        return 0;
    17d8:	31 c0                	xor    %eax,%eax
    17da:	eb 1c                	jmp    17f8 <malloc+0xb8>
    17dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    17e0:	39 cf                	cmp    %ecx,%edi
    17e2:	74 1c                	je     1800 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    17e4:	29 f9                	sub    %edi,%ecx
    17e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    17e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    17ec:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    17ef:	89 15 14 1c 00 00    	mov    %edx,0x1c14
      return (void*)(p + 1);
    17f5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    17f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    17fb:	5b                   	pop    %ebx
    17fc:	5e                   	pop    %esi
    17fd:	5f                   	pop    %edi
    17fe:	5d                   	pop    %ebp
    17ff:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1800:	8b 08                	mov    (%eax),%ecx
    1802:	89 0a                	mov    %ecx,(%edx)
    1804:	eb e9                	jmp    17ef <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1806:	c7 05 14 1c 00 00 18 	movl   $0x1c18,0x1c14
    180d:	1c 00 00 
    1810:	c7 05 18 1c 00 00 18 	movl   $0x1c18,0x1c18
    1817:	1c 00 00 
    base.s.size = 0;
    181a:	b8 18 1c 00 00       	mov    $0x1c18,%eax
    181f:	c7 05 1c 1c 00 00 00 	movl   $0x0,0x1c1c
    1826:	00 00 00 
    1829:	e9 3e ff ff ff       	jmp    176c <malloc+0x2c>
    182e:	66 90                	xchg   %ax,%ax

00001830 <uacquire>:
#include "uspinlock.h"
#include "x86.h"

void
uacquire(struct uspinlock *lk)
{
    1830:	55                   	push   %ebp
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1831:	b9 01 00 00 00       	mov    $0x1,%ecx
    1836:	89 e5                	mov    %esp,%ebp
    1838:	8b 55 08             	mov    0x8(%ebp),%edx
    183b:	90                   	nop
    183c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1840:	89 c8                	mov    %ecx,%eax
    1842:	f0 87 02             	lock xchg %eax,(%edx)
  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
    1845:	85 c0                	test   %eax,%eax
    1847:	75 f7                	jne    1840 <uacquire+0x10>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
    1849:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
}
    184e:	5d                   	pop    %ebp
    184f:	c3                   	ret    

00001850 <urelease>:

void urelease (struct uspinlock *lk) {
    1850:	55                   	push   %ebp
    1851:	89 e5                	mov    %esp,%ebp
    1853:	8b 45 08             	mov    0x8(%ebp),%eax
  __sync_synchronize();
    1856:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
    185b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1861:	5d                   	pop    %ebp
    1862:	c3                   	ret    
