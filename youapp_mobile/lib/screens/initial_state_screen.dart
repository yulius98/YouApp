

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/profile_service.dart';
import '../models/profile.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

/// Initial state screen that checks authentication and loads user profile
class InitialStateScreen extends StatefulWidget {
  const InitialStateScreen({super.key});

  @override
  State<InitialStateScreen> createState() => _InitialStateScreenState();
}

class _InitialStateScreenState extends State<InitialStateScreen> {
  UserProfile? _profile;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final profile = await ProfileService().getProfile();
      setState(() {
        _profile = profile;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _handleError() {
    if (_error != null &&
        (_error!.contains('No access token found') ||
         _error!.contains('invalid token'))) {
      _navigateToLogin();
    } else {
      _fetchProfile();
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

		@override
		Widget build(BuildContext context) {
			return Scaffold(
				backgroundColor: const Color(0xFF101828),
				appBar: AppBar(
					backgroundColor: const Color(0xFF101828),
					elevation: 0,
					leading: TextButton.icon(
						style: TextButton.styleFrom(
							padding: EdgeInsets.zero,
							minimumSize: const Size(0, 0),
							tapTargetSize: MaterialTapTargetSize.shrinkWrap,
							alignment: Alignment.centerLeft,
						),
						onPressed: () => Navigator.pushReplacement(
							context,
							MaterialPageRoute(builder: (context) => const LoginScreen()),
						),
						icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
						label: const Text('Back', style: TextStyle(color: Colors.white, fontSize: 12 )),
					),
					title: Text(
						_profile != null ? '@${_profile!.username}' : '',
						style: const TextStyle(
							color: Colors.white,
							fontWeight: FontWeight.w600,
							fontSize: 18,
						),
					),
					centerTitle: true,
					actions: [
						IconButton(
							icon: const Icon(Icons.more_horiz, color: Colors.white),
							onPressed: () {},
						),
					],
				),
				body: _loading
						? const Center(child: CircularProgressIndicator())
						: _error != null
								? Center(
										child: Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 16)),
												const SizedBox(height: 16),
												ElevatedButton(
													onPressed: _handleError,
													child: Text(_error!.contains('No access token found') || _error!.contains('invalid token') ? 'Back to Login' : 'Retry'),
												),
											],
										),
									)
								: _profile == null
										? const Center(child: Text('No profile data'))
										: SingleChildScrollView(
												child: Padding(
													padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.stretch,
														children: [
															// Profile Card
															Container(
																padding: const EdgeInsets.all(16),
																decoration: BoxDecoration(
																	color: const Color(0xFF1A2233),
																	borderRadius: BorderRadius.circular(16),
																),
																child: Stack(
																	children: [
																		Padding(
																			padding: const EdgeInsets.only(right: 32),
																			child: Text(
																				'@${_profile!.username}',
																				style: const TextStyle(
																					color: Colors.white,
																					fontWeight: FontWeight.w600,
																					fontSize: 18,
																				),
																			),
																		),
																																				Positioned(
																																						top: 0,
																																						right: 0,
																																						child: IconButton(
																																								icon: const Icon(Icons.edit, color: Color(0xFF98A2B3)),
																																								onPressed: () async {
																																									// read stored token and pass to ProfileScreen
																																									final storage = const FlutterSecureStorage();
																																									final token = await storage.read(key: 'access_token');
																																									if (token == null || token.isEmpty) {
																																										// no token -> back to login
																																										Navigator.pushReplacement(
																																											context,
																																											MaterialPageRoute(builder: (context) => const LoginScreen()),
																																										);
																																										return;
																																									}

																																									Navigator.pushReplacement(
																																										context,
																																										MaterialPageRoute(builder: (context) => ProfileScreen(token: token)),
																																									);
																																								},
																																						),
																																				),
																	],
																),
															),
															const SizedBox(height: 16),
															// About Card
															Container(
																padding: const EdgeInsets.all(16),
																decoration: BoxDecoration(
																	color: const Color(0xFF1A2233),
																	borderRadius: BorderRadius.circular(16),
																),
																child: Row(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		Expanded(
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					const Text(
																						'About',
																						style: TextStyle(
																							color: Colors.white,
																							fontWeight: FontWeight.w600,
																							fontSize: 16,
																						),
																					),
																					const SizedBox(height: 8),
																					Text(
																						_profile!.about?.isNotEmpty == true
																								? _profile!.about!
																								: 'Add in your about to help others know you better',
																						style: const TextStyle(
																							color: Color(0xFF98A2B3),
																							fontSize: 14,
																						),
																					),
																				],
																			),
																		),
																		IconButton(
																			icon: const Icon(Icons.edit, color: Color(0xFF98A2B3)),
																			onPressed: () {},
																		),
																	],
																),
															),
															const SizedBox(height: 16),
															// Interest Card
															Container(
																padding: const EdgeInsets.all(16),
																decoration: BoxDecoration(
																	color: const Color(0xFF1A2233),
																	borderRadius: BorderRadius.circular(16),
																),
																child: Row(
																	crossAxisAlignment: CrossAxisAlignment.start,
																	children: [
																		Expanded(
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					const Text(
																						'Interest',
																						style: TextStyle(
																							color: Colors.white,
																							fontWeight: FontWeight.w600,
																							fontSize: 16,
																						),
																					),
																					const SizedBox(height: 8),
																					_profile!.interests != null && _profile!.interests!.isNotEmpty
																							? Wrap(
																									spacing: 8,
																									children: _profile!.interests!
																											.map((e) => Chip(
																														label: Text(e),
																														backgroundColor: const Color(0xFF344054),
																														labelStyle: const TextStyle(color: Colors.white),
																													))
																											.toList(),
																								)
																							: const Text(
																									'Add in your interest to find a better match',
																									style: TextStyle(
																										color: Color(0xFF98A2B3),
																										fontSize: 14,
																									),
																								),
																				],
																			),
																		),
																		IconButton(
																			icon: const Icon(Icons.edit, color: Color(0xFF98A2B3)),
																			onPressed: () {},
																		),
																	],
																),
															),
														],
													),
												),
											),
			);
		}
	}

