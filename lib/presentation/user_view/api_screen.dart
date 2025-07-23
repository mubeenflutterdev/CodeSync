import 'package:flutter/material.dart';

class ApiScreen extends StatelessWidget {
  const ApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column());
  }
}

// class ApiScreen extends StatefulWidget {
//   const ApiScreen({super.key});
//   @override
//   State<ApiScreen> createState() => _ApiScreenState();
// }

// class _ApiScreenState extends State<ApiScreen> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   ApiProvider apiProvider = Provider.of<ApiProvider>(context, listen: false);
//   //   apiProvider.getApiData();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Consumer<ApiProvider>(
//             builder: (context, provider, child) {
//               return Expanded(
//                 child: provider.isLoading == true
//                     ? Center(child: CircularProgressIndicator())
//                     : ListView.builder(
//                         itemCount: provider.dataList.length,

//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text(provider.dataList[index].name),
//                             subtitle: Text(
//                               provider.dataList[index].createdAt.toString(),
//                             ),
//                             leading: CircleAvatar(
//                               backgroundImage: NetworkImage(
//                                 provider.dataList[index].avatar.toString(),
//                               ),
//                             ),
//                             trailing: Text(provider.dataList[index].id),
//                           );
//                         },
//                       ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
