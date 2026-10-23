import 'package:flutter/material.dart';

void main() => runApp(const DeepCleanApp());

const green = Color(0xFF16866B);
const dark = Color(0xFF173C35);
const pale = Color(0xFFEAF7F2);
const ink = Color(0xFF23332F);
const muted = Color(0xFF71817C);

class DeepCleanApp extends StatelessWidget {
  const DeepCleanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'deepclean.com',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FBF9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          primary: green,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8FBF9),
          foregroundColor: dark,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF5F8F6),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5ECE8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: green, width: 1.5),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class CleaningPackage {
  final String name;
  final String subtitle;
  final String price;
  final IconData icon;
  final List<String> includes;
  const CleaningPackage({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.icon,
    required this.includes,
  });
}

const packages = <CleaningPackage>[
  CleaningPackage(
    name: 'Essential Clean',
    subtitle: 'A fresh start for everyday living',
    price: '₹999',
    icon: Icons.cleaning_services_outlined,
    includes: ['Dusting & sweeping', 'Kitchen surface cleaning', 'Bathroom refresh'],
  ),
  CleaningPackage(
    name: 'Deep Home Clean',
    subtitle: 'A detailed clean from corner to corner',
    price: '₹2,499',
    icon: Icons.home_work_outlined,
    includes: ['Everything in Essential', 'Deep bathroom cleaning', 'Floor & tile scrubbing'],
  ),
  CleaningPackage(
    name: 'Premium Care',
    subtitle: 'Extra care for your whole home',
    price: '₹3,999',
    icon: Icons.auto_awesome_outlined,
    includes: ['Everything in Deep Home', 'Appliance exterior cleaning', 'Balcony & extra detailing'],
  ),
  CleaningPackage(
    name: 'Household Helper',
    subtitle: 'Help with everyday household chores',
    price: '₹799',
    icon: Icons.spa_outlined,
    includes: ['Laundry folding', 'Room organisation', 'Light household chores'],
  ),
];

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

String? requiredValidator(String? value) =>
    value == null || value.trim().isEmpty ? 'This field is required' : null;

class Brand extends StatelessWidget {
  final bool compact;
  const Brand({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 38 : 46,
          height: compact ? 38 : 46,
          decoration: BoxDecoration(
            color: green,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.water_drop_rounded, color: Colors.white, size: 25),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('deepclean.com',
                style: TextStyle(
                  color: dark,
                  fontWeight: FontWeight.w800,
                  fontSize: compact ? 17 : 20,
                )),
            if (!compact)
              const Text('A cleaner home. A calmer you.',
                  style: TextStyle(color: muted, fontSize: 11)),
          ],
        ),
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void login() {
    if (!formKey.currentState!.validate()) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardPage(customerName: email.text.split('@').first),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      heading: 'Welcome back!',
      subtitle: 'Your fresh, happy home is just a few clicks away.',
      form: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Email address', style: fieldLabel),
            const SizedBox(height: 8),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'you@example.com',
                prefixIcon: Icon(Icons.mail_outline),
              ),
              validator: (v) {
                if (v == null || !v.contains('@') || !v.contains('.')) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            const Text('Password', style: fieldLabel),
            const SizedBox(height: 8),
            TextFormField(
              controller: password,
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                  icon: Icon(hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                ),
              ),
              validator: (v) =>
              v == null || v.length < 4 ? 'Use at least 4 characters' : null,
              onFieldSubmitted: (_) => login(),
            ),
            const SizedBox(height: 24),
            PrimaryButton(label: 'Login to your account', onPressed: login),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: green,
                side: const BorderSide(color: Color(0xFFB8DCD0)),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Create a new account'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Exam demo: enter any valid email and a password of 4+ characters.',
              textAlign: TextAlign.center,
              style: TextStyle(color: muted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

const fieldLabel = TextStyle(color: ink, fontWeight: FontWeight.w700, fontSize: 13);

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  void register() {
    if (!formKey.currentState!.validate()) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => DashboardPage(customerName: name.text.trim())),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      heading: 'Create your account',
      subtitle: 'Join us for a cleaner, more comfortable home.',
      form: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Full name', style: fieldLabel),
            const SizedBox(height: 8),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(hintText: 'Your full name', prefixIcon: Icon(Icons.person_outline)),
              validator: requiredValidator,
            ),
            const SizedBox(height: 14),
            const Text('Email address', style: fieldLabel),
            const SizedBox(height: 8),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'you@example.com', prefixIcon: Icon(Icons.mail_outline)),
              validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null,
            ),
            const SizedBox(height: 14),
            const Text('Phone number', style: fieldLabel),
            const SizedBox(height: 8),
            TextFormField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: '10-digit phone number', prefixIcon: Icon(Icons.phone_outlined)),
              validator: (v) => v == null || v.replaceAll(RegExp(r'\D'), '').length < 10
                  ? 'Enter a valid phone number'
                  : null,
            ),
            const SizedBox(height: 14),
            const Text('Password', style: fieldLabel),
            const SizedBox(height: 8),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Create a password', prefixIcon: Icon(Icons.lock_outline)),
              validator: (v) => v == null || v.length < 4 ? 'Use at least 4 characters' : null,
            ),
            const SizedBox(height: 22),
            PrimaryButton(label: 'Register', onPressed: register),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthScaffold extends StatelessWidget {
  final String heading;
  final String subtitle;
  final Widget form;
  const AuthScaffold({
    super.key,
    required this.heading,
    required this.subtitle,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: Brand()),
                  const SizedBox(height: 34),
                  Container(
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: const Color(0xFFE8EFEB)),
                      boxShadow: const [
                        BoxShadow(color: Color(0x0D173C35), blurRadius: 28, offset: Offset(0, 12)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(heading, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: dark)),
                        const SizedBox(height: 8),
                        Text(subtitle, style: const TextStyle(color: muted, height: 1.5)),
                        const SizedBox(height: 26),
                        form,
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('TRUSTED CARE • SPOTLESS RESULTS • MORE FREE TIME',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: muted, fontSize: 10, letterSpacing: 1.1)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const PrimaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final String customerName;
  const DashboardPage({super.key, required this.customerName});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1000 ? 3 : width >= 620 ? 2 : 1;
    return Scaffold(
      appBar: AppBar(
        title: const Brand(compact: true),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
                  (_) => false,
            ),
            icon: const Icon(Icons.logout, size: 18),
            label: const Text('Logout'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEAF7F2), Color(0xFFF4FAF6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: LayoutBuilder(builder: (context, constraints) {
                      final narrow = constraints.maxWidth < 540;
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                                  child: const Text('✦  YOUR HOME, OUR CARE', style: TextStyle(color: green, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1)),
                                ),
                                const SizedBox(height: 18),
                                Text('Hello, ${customerName.isEmpty ? 'there' : customerName}!',
                                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: dark)),
                                const SizedBox(height: 8),
                                const Text('Come home to clean. We’ll take care of the chores.',
                                    style: TextStyle(color: muted, height: 1.5)),
                                const SizedBox(height: 20),
                                FilledButton.icon(
                                  onPressed: () => Scrollable.ensureVisible(
                                    context,
                                    duration: const Duration(milliseconds: 350),
                                    alignment: 0.15,
                                  ),
                                  icon: const Icon(Icons.arrow_downward, size: 17),
                                  label: const Text('Explore packages'),
                                  style: FilledButton.styleFrom(backgroundColor: green, foregroundColor: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          if (!narrow) ...[
                            const SizedBox(width: 16),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.8), shape: BoxShape.circle),
                              child: const Icon(Icons.cleaning_services_rounded, size: 82, color: green),
                            ),
                          ],
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 34),
                  const Text('Cleaning made simple', style: TextStyle(color: dark, fontSize: 25, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Text('Choose the service that fits your home and budget.', style: TextStyle(color: muted)),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: packages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 360,
                    ),
                    itemBuilder: (context, index) => PackageCard(
                      package: packages[index],
                      onBook: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingPage(
                            customerName: customerName,
                            selectedPackage: packages[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(color: dark, borderRadius: BorderRadius.circular(22)),
                    child: const Row(
                      children: [
                        Icon(Icons.verified_user_outlined, color: Color(0xFF9BE0C7), size: 30),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Care you can count on', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                              SizedBox(height: 5),
                              Text('Thoughtful service, clear prices, and more time for what matters.', style: TextStyle(color: Color(0xFFD0E1DA), height: 1.4)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Center(child: Text('© 2026 deepclean.com · A cleaner home starts here.', style: TextStyle(color: muted, fontSize: 12))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PackageCard extends StatelessWidget {
  final CleaningPackage package;
  final VoidCallback onBook;
  const PackageCard({super.key, required this.package, required this.onBook});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE6EEEA)),
        boxShadow: const [BoxShadow(color: Color(0x07173C35), blurRadius: 16, offset: Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(16)),
            child: Icon(package.icon, color: green, size: 27),
          ),
          const SizedBox(height: 16),
          Text(package.name, style: const TextStyle(color: dark, fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(package.subtitle, style: const TextStyle(color: muted, fontSize: 12, height: 1.4)),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(package.price, style: const TextStyle(color: green, fontSize: 27, fontWeight: FontWeight.w800)),
              const Padding(
                padding: EdgeInsets.only(bottom: 5, left: 5),
                child: Text('/ visit', style: TextStyle(color: muted, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Divider(color: Color(0xFFECF1EE)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: package.includes.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle, size: 16, color: green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item, style: const TextStyle(color: ink, fontSize: 12))),
                  ],
                ),
              )).toList(),
            ),
          ),
          PrimaryButton(label: 'Book this package', onPressed: onBook),
        ],
      ),
    );
  }
}

class BookingPage extends StatefulWidget {
  final String customerName;
  final CleaningPackage selectedPackage;
  const BookingPage({super.key, required this.customerName, required this.selectedPackage});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController name;
  final phone = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final instructions = TextEditingController();
  DateTime? selectedDate;
  String homeType = 'Apartment';

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.customerName);
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    address.dispose();
    city.dispose();
    instructions.dispose();
    super.dispose();
  }

  Future<void> chooseDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 180)),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void submitBooking() {
    if (!formKey.currentState!.validate()) return;
    if (selectedDate == null) {
      showMessage(context, 'Please select your preferred service date.');
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SuccessPage(
          customerName: name.text.trim(),
          package: widget.selectedPackage,
          date: selectedDate!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateText = selectedDate == null
        ? 'Choose a date'
        : '${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a cleaning service', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: pale, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, color: green, size: 32),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.selectedPackage.name, style: const TextStyle(color: dark, fontWeight: FontWeight.w800, fontSize: 18)),
                              Text('${widget.selectedPackage.price} / visit', style: const TextStyle(color: green, fontWeight: FontWeight.w800, fontSize: 17)),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Change'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Your booking details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: dark)),
                  const SizedBox(height: 7),
                  const Text('Tell us a little about you and your home.', style: TextStyle(color: muted)),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Full name', style: fieldLabel),
                        const SizedBox(height: 7),
                        TextFormField(controller: name, decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline), hintText: 'Enter your full name'), validator: requiredValidator),
                        const SizedBox(height: 15),
                        const Text('Phone number', style: fieldLabel),
                        const SizedBox(height: 7),
                        TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(prefixIcon: Icon(Icons.phone_outlined), hintText: '10-digit phone number'),
                          validator: (v) => v == null || v.replaceAll(RegExp(r'\D'), '').length < 10 ? 'Enter a valid phone number' : null,
                        ),
                        const SizedBox(height: 15),
                        const Text('House address', style: fieldLabel),
                        const SizedBox(height: 7),
                        TextFormField(
                          controller: address,
                          minLines: 2,
                          maxLines: 3,
                          decoration: const InputDecoration(prefixIcon: Icon(Icons.location_on_outlined), hintText: 'House / flat number, street, area'),
                          validator: requiredValidator,
                        ),
                        const SizedBox(height: 15),
                        const Text('City / PIN code', style: fieldLabel),
                        const SizedBox(height: 7),
                        TextFormField(controller: city, decoration: const InputDecoration(prefixIcon: Icon(Icons.location_city_outlined), hintText: 'City and PIN code'), validator: requiredValidator),
                        const SizedBox(height: 15),
                        const Text('Type of home', style: fieldLabel),
                        const SizedBox(height: 7),
                        DropdownButtonFormField<String>(
                          value: homeType,
                          decoration: const InputDecoration(prefixIcon: Icon(Icons.home_outlined)),
                          items: const [
                            DropdownMenuItem(value: 'Apartment', child: Text('Apartment')),
                            DropdownMenuItem(value: 'Independent house', child: Text('Independent house')),
                            DropdownMenuItem(value: 'Villa', child: Text('Villa')),
                            DropdownMenuItem(value: 'Other', child: Text('Other')),
                          ],
                          onChanged: (v) => setState(() => homeType = v ?? 'Apartment'),
                        ),
                        const SizedBox(height: 15),
                        const Text('Preferred service date', style: fieldLabel),
                        const SizedBox(height: 7),
                        OutlinedButton.icon(
                          onPressed: chooseDate,
                          icon: const Icon(Icons.calendar_month_outlined),
                          label: Text(dateText),
                          style: OutlinedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(17),
                            foregroundColor: selectedDate == null ? muted : green,
                            side: const BorderSide(color: Color(0xFFE5ECE8)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text('Additional instructions (optional)', style: fieldLabel),
                        const SizedBox(height: 7),
                        TextFormField(controller: instructions, maxLines: 3, decoration: const InputDecoration(hintText: 'Any special requests for our team?')),
                        const SizedBox(height: 24),
                        PrimaryButton(label: 'Confirm booking · ${widget.selectedPackage.price}', onPressed: submitBooking),
                        const SizedBox(height: 12),
                        const Text('Demo only: booking details are not sent to a real cleaning company.', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  final String customerName;
  final CleaningPackage package;
  final DateTime date;
  const SuccessPage({super.key, required this.customerName, required this.package, required this.date});

  @override
  Widget build(BuildContext context) {
    final dateText = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFE6EEEA)),
                ),
                child: Column(
                  children: [
                    const Brand(),
                    const SizedBox(height: 38),
                    Container(
                      width: 94,
                      height: 94,
                      decoration: const BoxDecoration(color: pale, shape: BoxShape.circle),
                      child: const Icon(Icons.check_rounded, color: green, size: 58),
                    ),
                    const SizedBox(height: 24),
                    const Text('Booking successful!', textAlign: TextAlign.center, style: TextStyle(color: dark, fontSize: 28, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    Text('Thank you, $customerName. Your demo booking has been recorded on this screen.',
                        textAlign: TextAlign.center, style: const TextStyle(color: muted, height: 1.5)),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: const Color(0xFFF5F9F6), borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          _SummaryRow(label: 'Selected package', value: package.name),
                          const Divider(height: 24),
                          _SummaryRow(label: 'Service date', value: dateText),
                          const Divider(height: 24),
                          _SummaryRow(label: 'Total price', value: package.price, valueColor: green),
                          const Divider(height: 24),
                          const _SummaryRow(label: 'Status', value: 'Successful'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    PrimaryButton(
                      label: 'Back to dashboard',
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => DashboardPage(customerName: customerName)),
                            (_) => false,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                            (_) => false,
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _SummaryRow({required this.label, required this.value, this.valueColor = ink});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label, style: const TextStyle(color: muted, fontSize: 13))),
        const SizedBox(width: 12),
        Flexible(
          child: Text(value, textAlign: TextAlign.end, style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 13)),
        ),
      ],
    );
  }
}
